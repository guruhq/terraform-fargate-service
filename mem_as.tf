resource "aws_cloudwatch_metric_alarm" "service_mem_high" {
  alarm_name          = "${var.project}-${var.environment}-service-MEM-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.mem_up_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.mem_up_time_period
  statistic           = "Average"
  threshold           = var.mem_threshold_up

  dimensions = {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${aws_ecs_service.main.name}"
  }

  alarm_actions = concat([aws_appautoscaling_policy.mem_up.arn], var.additional_scale_alarm_actions)


  depends_on = [aws_cloudwatch_metric_alarm.service_cpu_high]
}

resource "aws_cloudwatch_metric_alarm" "service_mem_low" {
  alarm_name          = "${var.project}-${var.environment}-service-MEM-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.mem_down_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.mem_down_time_period
  statistic           = "Average"
  threshold           = var.mem_threshold_down

  dimensions = {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${aws_ecs_service.main.name}"
  }

  alarm_actions = concat([aws_appautoscaling_policy.mem_down.arn], var.additional_scale_alarm_actions)

  depends_on = [aws_cloudwatch_metric_alarm.service_cpu_low]
}

resource "aws_appautoscaling_target" "mem_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = var.service_role_arn
  min_capacity       = var.service_asg_min_cap
  max_capacity       = var.service_asg_max_cap

  depends_on = [
    aws_ecs_service.main,
    aws_appautoscaling_target.scale_target
  ]

}

resource "aws_appautoscaling_policy" "mem_up" {
  name               = "${var.project}-${var.environment}-mem-scale-up"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.mem_up_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [
    aws_appautoscaling_target.mem_scale_target,
    aws_appautoscaling_policy.cpu_up
  ]
}

resource "aws_appautoscaling_policy" "mem_down" {
  name               = "${var.project}-${var.environment}-mem-scale-down"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.mem_down_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [
    aws_appautoscaling_target.mem_scale_target,
    aws_appautoscaling_policy.cpu_down
  ]
}
