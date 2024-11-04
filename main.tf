## Module for ECS Infrastructure
########################################################################################################################

module "ecs_infrastructure" {
  source = "./module"
  for_each = var.containers
  
  ########################################################################################################################
  ## Service variables
  ########################################################################################################################

  namespace           = var.namespace
  domain_name         = var.domain_name
  service_name        = each.value.service_name
  scenario            = var.scenario
  environment         = var.environment

  ########################################################################################################################
  ## AWS credentials
  ########################################################################################################################

  region              = var.region

  ########################################################################################################################
  ## Network variables
  ########################################################################################################################

  vpc_cidr_block      = var.vpc_cidr_block
  az_count            = var.az_count

  ########################################################################################################################
  ## EC2 Computing variables
  ########################################################################################################################

  public_ec2_key      = var.public_ec2_key
  instance_type       = var.instance_type

  ########################################################################################################################
  ## ECS variables
  ########################################################################################################################

  ecs_task_desired_count                      = each.value.ecs_task_desired_count
  ecs_task_min_count                          = var.ecs_task_min_count
  ecs_task_max_count                          = var.ecs_task_max_count
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  cpu_target_tracking_desired_value           = var.cpu_target_tracking_desired_value
  memory_target_tracking_desired_value        = var.memory_target_tracking_desired_value
  maximum_scaling_step_size                   = var.maximum_scaling_step_size
  minimum_scaling_step_size                   = var.minimum_scaling_step_size
  target_capacity                             = var.target_capacity
  container_port                              = each.value.container_port
  cpu_units                                   = each.value.cpu_units
  memory                                      = each.value.memory

  ########################################################################################################################
  ## Cloudwatch
  ########################################################################################################################

  retention_in_days   = var.retention_in_days

  ########################################################################################################################
  ## ECR
  ########################################################################################################################

  image_uri           = each.value.image_uri

  ########################################################################################################################
  ## Autoscaling Group
  ########################################################################################################################

  autoscaling_max_size = var.autoscaling_max_size
  autoscaling_min_size = var.autoscaling_min_size

  ########################################################################################################################
  ## ALB
  ########################################################################################################################

  custom_origin_host_header = var.custom_origin_host_header
  healthcheck_endpoint      = var.healthcheck_endpoint
  healthcheck_matcher       = var.healthcheck_matcher
  aws_acm_certificate_arn   = var.aws_acm_certificate_arn


  #launch_type = var.launch_type
}
