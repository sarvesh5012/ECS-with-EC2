# # Module for ECS Infrastructure
# main.tf

locals {
  yaml_vars = yamldecode(file("variables.yml"))
}

# Define individual local variables to hold values for easy reference
locals {
  namespace = local.yaml_vars["namespace"]

  environment                                 = local.yaml_vars["environment"]
  region                                      = local.yaml_vars["region"]
  vpc_cidr_block                              = local.yaml_vars["vpc_cidr_block"]
  azs                                         = local.yaml_vars["azs"]
  public_subnets                              = local.yaml_vars["public_subnets"]
  private_subnets                             = local.yaml_vars["private_subnets"]
  instance_type                               = local.yaml_vars["instance_type"]
  containers                                  = local.yaml_vars["containers"]
  ecs_task_min_count                          = local.yaml_vars["ecs_task_min_count"]
  ecs_task_max_count                          = local.yaml_vars["ecs_task_max_count"]
  ecs_task_deployment_minimum_healthy_percent = local.yaml_vars["ecs_task_deployment_minimum_healthy_percent"]
  ecs_task_deployment_maximum_percent         = local.yaml_vars["ecs_task_deployment_maximum_percent"]

  maximum_scaling_step_size = local.yaml_vars["maximum_scaling_step_size"]
  minimum_scaling_step_size = local.yaml_vars["minimum_scaling_step_size"]
  target_capacity           = local.yaml_vars["target_capacity"]
  retention_in_days         = local.yaml_vars["retention_in_days"]
  autoscaling_max_size      = local.yaml_vars["autoscaling_max_size"]
  autoscaling_min_size      = local.yaml_vars["autoscaling_min_size"]
  desired_capacity          = local.yaml_vars["desired_capacity"]

  healthcheck_matcher              = local.yaml_vars["healthcheck_matcher"]
  aws_acm_certificate_arn          = local.yaml_vars["aws_acm_certificate_arn"]
  launch_type                      = local.yaml_vars["launch_type"]
  enable_cross_zone_load_balancing = local.yaml_vars["enable_cross_zone_load_balancing"]
  tags                             = local.yaml_vars["tags"]
}



module "ecs_infrastructure" {
  source = "./module"

  namespace = local.namespace

  environment                                 = local.environment
  region                                      = local.region
  vpc_id                                      = module.vpc.vpc_id
  public_subnet_ids                           = module.vpc.public_subnets
  private_subnet_ids                          = module.vpc.private_subnets
  azs                                         = local.azs
  private_subnets                             = local.private_subnets
  public_subnets                              = local.public_subnets
  instance_type                               = local.instance_type
  containers                                  = local.containers
  ecs_task_min_count                          = local.ecs_task_min_count
  ecs_task_max_count                          = local.ecs_task_max_count
  ecs_task_deployment_minimum_healthy_percent = local.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = local.ecs_task_deployment_maximum_percent

  maximum_scaling_step_size = local.maximum_scaling_step_size
  minimum_scaling_step_size = local.minimum_scaling_step_size
  target_capacity           = local.target_capacity
  retention_in_days         = local.retention_in_days
  autoscaling_max_size      = local.autoscaling_max_size
  autoscaling_min_size      = local.autoscaling_min_size
  desired_capacity          = local.desired_capacity

  healthcheck_matcher              = local.healthcheck_matcher
  aws_acm_certificate_arn          = local.aws_acm_certificate_arn
  launch_type                      = local.launch_type
  enable_cross_zone_load_balancing = local.enable_cross_zone_load_balancing
  tags                             = local.tags
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  cidr = local.vpc_cidr_block

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets


  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = merge({
    Name = "${local.namespace}_VPC_${local.environment}"
  }, local.tags)
}