resource "aws_ecs_service" "main" {
  name            = var.project
  cluster         = var.cluster_name
  task_definition = var.task_definition
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.container_security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.lb_container_name
    container_port   = var.lb_container_port
  }

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  lifecycle {
    ignore_changes = [load_balancer, desired_count]
  }

  deployment_controller {
    type = var.deployment_type
  }
}
