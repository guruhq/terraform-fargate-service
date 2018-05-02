resource "aws_ecs_service" "main" {
  name            = "${var.project}"
  cluster         = "${var.cluster_name}"
  task_definition = "${var.task_definition}"
  desired_count   = "${var.service_desired_count}"
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = "${var.private_subnet_ids}"
    security_groups  = "${var.container_security_groups}"
    assign_public_ip = "${var.assign_public_ip}"
  }

 load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "${var.lb_container_name}"
    container_port   = "${var.lb_container_port}"
  }

  lifecycle {
    ignore_changes = ["desired_count"]
  }
}
