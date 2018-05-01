# ecs-service-tf

A Terraform module to create an Amazon Web Services (AWS) ECS Service on top of an ECS cluster.

## Usage

```hcl
module "container_service" {
  source = "git::ssh://git@github.com/guruhq/ecs-service-terraform?ref=2.0.0"

  cluster_name = "test-cluster"
  vpc_id       = "vpc-12345678"

  lb_container_name = "nginx-frontend"
  lb_container_port = 80
  public_subnet_ids = [...]
  target_group_arn  = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
  
  service_desired_count = 3
  service_asg_min_cap = 3
  service_asg_max_cap = 12  

  project     = "docker-test-app"
  task_definition = "docker-test-app:1"
  environment = "dev"
}
```

## Variables

- `lb_container_name` - Name of the container the ALB should route traffic too (Default: `unknown`)
- `lb_container_port` - Port the ALB will route traffic to on the container (Default: `unknown`)
- `custom_url` - Prefix for the URL - environment will append. I.e. test will be test-env.whatever.com (Default `unknown`)
- `service_desired_count` - Number of services desired to run - Ignored after initial run (Default: `1`)
- `region` - Where it all happens (Default: `us-east-1`)
- `mem_threshold_up` - Percentage of MEM utilization to trigger scaling up action (Default: `60`)
- `mem_up_evaluation_periods` - How many periods of alarm until scaling up is triggered (Default: `3`)
- `mem_up_time_period` - How much time is one period (Default: `60`)
- `mem_up_cooldown` - How much time inbetween scaling actions in seconds (Default: `240`)
- `mem_threshold_down` - Percentage of MEM utilization to trigger scaling down action (Default: `20`)
- `mem_down_evaluation_periods` - How many periods of alarm until scalind down is triggered (Default `1`)
- `mem_down_time_period` - How much time is one period (Default: `300`)
- `mem_down_cooldown` - How much time inbetween scalind actions in seconds (Default: `300`)
- `cpu_threshold_up` - Percentage of CPU utilization to trigger scaling up action (Default: `60`)
- `cpu_up_evaluation_periods` - How many periods of alarm until scaling up is triggered (Default: `3`)
- `cpu_up_time_period` - How much time is one period (Default: `60`)
- `cpu_up_cooldown` - How much time inbetween scaling actions in seconds (Default: `240`)
- `cpu_threshold_down` - Percentage of CPU utilization to trigger scaling down action (Default: `20`)
- `cpu_down_evaluation_periods` - How many periods of alarm until scalind down is triggered (Default `1`)
- `cpu_down_time_period` - How much time is one period (Default: `300`)
- `cpu_down_cooldown` - How much time inbetween scalind actions in seconds (Default: `300`)
- `service_asg_min_cap` - Minimum number of services running (Default: `1`)
- `service_asg_max_cap` - Maximum number of services running (Default: `3`)
- `project` - Name of the project or application (Default: `unknown`)
- `cluster_name` - Name of the cluster to launch into (Default: `unknown`)
- `task_definition` - Full task definition - taskdef:refNum (Default: `unknown`)
- `public_subnet_ids` - List of subnet ID's to launch ALB into - format ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] (Default: `unknown`)
- `environment` - Service environment (Default: `unknown`)
- `vpc_id` - VPC to launch into (Default: `unknown`)

## Outputs

- `name` - The container service Name 
