variable "vpc_id" {}
variable "task_definition" {}
variable "target_group_arn" {}
variable "project" {}
variable "lb_container_name" {}
variable "lb_container_port" {}
variable "cluster_name" {
  default = "dev-cluster"
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "container_security_groups" {
  type = list(string)
}
variable "assign_public_ip" {
  default = "false"
}
variable "environment" {
  default = "dev"
}
variable "service_desired_count" {
  default = 3
}
variable "mem_threshold_up" {
  default = 60
}
variable "mem_up_evaluation_periods" {
  default = 3
}
variable "mem_up_time_period" {
  default = 60
}
variable "mem_up_cooldown" {
  default = 240
}
variable "mem_threshold_down" {
  default = 20
}
variable "mem_down_evaluation_periods" {
  default = 1
}
variable "mem_down_time_period" {
  default = 300
}
variable "mem_down_cooldown" {
  default = 300
}
variable "cpu_threshold_up" {
  default = 60
}
variable "cpu_up_evaluation_periods" {
  default = 3
}
variable "cpu_up_time_period" {
  default = 60
}
variable "cpu_up_cooldown" {
  default = 240
}
variable "cpu_threshold_down" {
  default = 20
}
variable "cpu_down_evaluation_periods" {
  default = 1
}
variable "cpu_down_time_period" {
  default = 300
}
variable "cpu_down_cooldown" {
  default = 300
}
variable "service_asg_min_cap" {
  default = 1
}
variable "service_asg_max_cap" {
  default = 12
}
variable "health_check_grace_period_seconds" {
  default = 300
}
variable "deployment_type" {
  default = "ECS"
}
variable "service_role_arn" {
  default = "arn:aws:iam::495243515911:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
}
variable "additional_scale_alarm_actions" {
  type    = list(string)
  default = []
}

