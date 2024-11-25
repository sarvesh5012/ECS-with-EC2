# # Module for ECS Infrastructure
# main.tf

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"
  name    = "${local.namespace}_VPC_${local.environment}"
  cidr    = local.vpc_cidr_block

  azs              = local.azs
  private_subnets  = local.private_subnets
  public_subnets   = local.public_subnets
  database_subnets = local.database_subnets


  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = merge({
    Name = "${local.namespace}_VPC_${local.environment}"
  }, local.common_tags)
}

module "ecs_infrastructure" {
  source                                      = "./module/ecs"
  namespace                                   = local.namespace
  environment                                 = local.environment
  public_subnet_ids                           = module.vpc.public_subnets
  private_subnet_ids                          = module.vpc.private_subnets
  instance_type                               = local.instance_type
  launch_type                                 = local.launch_type #If instance_type is there then the launch_tyep wiill be ec2
  containers                                  = local.containers
  ecs_task_deployment_minimum_healthy_percent = local.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = local.ecs_task_deployment_maximum_percent
  maximum_scaling_step_size                   = local.maximum_scaling_step_size
  minimum_scaling_step_size                   = local.minimum_scaling_step_size
  asg_ec2_target_capacity                     = local.asg_ec2_target_capacity
  cw_logs_retention_in_days                   = local.cw_logs_retention_in_days
  ec2_autoscaling_max_size                    = local.ec2_autoscaling_max_size
  ec2_autoscaling_min_size                    = local.ec2_autoscaling_min_size
  ec2_desired_capacity                        = local.ec2_desired_capacity
  aws_acm_certificate_arn                     = local.aws_acm_certificate_arn
  enable_cross_zone_load_balancing            = local.enable_cross_zone_load_balancing

}

module "rds" {
  # source = "terraform-aws-modules/rds/aws"
  source = "./module/rds"

  identifier                          = local.identifier
  engine                              = local.engine
  engine_version                      = local.engine_version
  instance_class                      = local.instance_class
  allocated_storage                   = local.allocated_storage
  db_name                             = local.db_name
  username                            = local.username
  port                                = local.port
  iam_database_authentication_enabled = local.iam_database_authentication_enabled
  create_monitoring_role              = local.create_monitoring_role
  create_db_subnet_group              = local.create_db_subnet_group
  family                              = local.family
  major_engine_version                = local.major_engine_version
  deletion_protection                 = local.deletion_protection
  database_subnets_ids                = module.vpc.database_subnets
}

module "backup_vault" {
  source                        = "./module/rds/backup_vault"
  backup_vault_name             = local.backup_vault_name
  backup_service_selection_name = local.backup_service_selection_name
  bp_name                       = local.bp_name
  bp_rule_schedule              = local.bp_rule_schedule
  delete_after                  = local.delete_after
  schedule_expression_timezone  = local.schedule_expression_timezone
  start_window                  = local.start_window
  completion_window             = local.completion_window
  resources_arn                 = module.rds.db_instance_arn
  bp_rule_name                  = local.bp_rule_name
}

module "app_deployment_cicd" {
  source            = "./module/cicd_aws_role"
  oidc_provider_url = local.oidc_provider_url
}