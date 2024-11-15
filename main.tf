# # Module for ECS Infrastructure

# module "ecs_infrastructure" {
#   source = "./module"

#     # Service variables
  
#   namespace           = var.namespace
#   # domain_name         = var.domain_name
#   scenario            = var.scenario
#   environment         = var.environment

#     # AWS credentials
  
#   region              = var.region

#     # Network variables
  
#   vpc_cidr_block      = var.vpc_cidr_block
#   az_count            = var.az_count

#     # EC2 Computing variables
  
#   # public_ec2_key      = var.public_ec2_key
#   instance_type       = var.instance_type

#     # ECS variables
#   containers = var.containers
#   ecs_task_min_count                          = var.ecs_task_min_count
#   ecs_task_max_count                          = var.ecs_task_max_count
#   ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
#   ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
#   cpu_target_tracking_desired_value           = var.cpu_target_tracking_desired_value
#   memory_target_tracking_desired_value        = var.memory_target_tracking_desired_value
#   maximum_scaling_step_size                   = var.maximum_scaling_step_size
#   minimum_scaling_step_size                   = var.minimum_scaling_step_size
#   target_capacity                             = var.target_capacity

#     # Cloudwatch
  
#   retention_in_days   = var.retention_in_days

#     # Autoscaling Group
  
#   autoscaling_max_size = var.autoscaling_max_size
#   autoscaling_min_size = var.autoscaling_min_size
#   desired_capacity     = var.desired_capacity

#     # ALB
  
#   # custom_origin_host_header = var.custom_origin_host_header
#   healthcheck_endpoint      = var.healthcheck_endpoint
#   healthcheck_matcher       = var.healthcheck_matcher
#   aws_acm_certificate_arn   = var.aws_acm_certificate_arn


#   launch_type = var.launch_type
# }



# main.tf

locals {
  yaml_vars = yamldecode(file("variables.yml"))
}

# Define individual local variables to hold values for easy reference
locals {
  namespace                               = local.yaml_vars["namespace"]
  scenario                                = local.yaml_vars["scenario"]
  environment                             = local.yaml_vars["environment"]
  region                                  = local.yaml_vars["region"]
  vpc_cidr_block                          = local.yaml_vars["vpc_cidr_block"]
  az_count                                = local.yaml_vars["az_count"]
  instance_type                           = local.yaml_vars["instance_type"]
  containers                              = local.yaml_vars["containers"]
  ecs_task_min_count                      = local.yaml_vars["ecs_task_min_count"]
  ecs_task_max_count                      = local.yaml_vars["ecs_task_max_count"]
  ecs_task_deployment_minimum_healthy_percent = local.yaml_vars["ecs_task_deployment_minimum_healthy_percent"]
  ecs_task_deployment_maximum_percent     = local.yaml_vars["ecs_task_deployment_maximum_percent"]
  cpu_target_tracking_desired_value       = local.yaml_vars["cpu_target_tracking_desired_value"]
  memory_target_tracking_desired_value    = local.yaml_vars["memory_target_tracking_desired_value"]
  maximum_scaling_step_size               = local.yaml_vars["maximum_scaling_step_size"]
  minimum_scaling_step_size               = local.yaml_vars["minimum_scaling_step_size"]
  target_capacity                         = local.yaml_vars["target_capacity"]
  retention_in_days                       = local.yaml_vars["retention_in_days"]
  autoscaling_max_size                    = local.yaml_vars["autoscaling_max_size"]
  autoscaling_min_size                    = local.yaml_vars["autoscaling_min_size"]
  desired_capacity                        = local.yaml_vars["desired_capacity"]
  healthcheck_endpoint                    = local.yaml_vars["healthcheck_endpoint"]
  healthcheck_matcher                     = local.yaml_vars["healthcheck_matcher"]
  aws_acm_certificate_arn                 = local.yaml_vars["aws_acm_certificate_arn"]
  launch_type                             = local.yaml_vars["launch_type"]
  tags                                    = local.yaml_vars["tags"]
}



module "ecs_infrastructure" {
  source = "./module"

  namespace                               = local.namespace
  scenario                                = local.scenario
  environment                             = local.environment
  region                                  = local.region
  vpc_cidr_block                          = local.vpc_cidr_block
  az_count                                = local.az_count
  instance_type                           = local.instance_type
  containers                              = local.containers
  ecs_task_min_count                      = local.ecs_task_min_count
  ecs_task_max_count                      = local.ecs_task_max_count
  ecs_task_deployment_minimum_healthy_percent = local.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent     = local.ecs_task_deployment_maximum_percent
  cpu_target_tracking_desired_value       = local.cpu_target_tracking_desired_value
  memory_target_tracking_desired_value    = local.memory_target_tracking_desired_value
  maximum_scaling_step_size               = local.maximum_scaling_step_size
  minimum_scaling_step_size               = local.minimum_scaling_step_size
  target_capacity                         = local.target_capacity
  retention_in_days                       = local.retention_in_days
  autoscaling_max_size                    = local.autoscaling_max_size
  autoscaling_min_size                    = local.autoscaling_min_size
  desired_capacity                        = local.desired_capacity
  healthcheck_endpoint                    = local.healthcheck_endpoint
  healthcheck_matcher                     = local.healthcheck_matcher
  aws_acm_certificate_arn                 = local.aws_acm_certificate_arn
  launch_type                             = local.launch_type
  tags                                    = local.tags
}
