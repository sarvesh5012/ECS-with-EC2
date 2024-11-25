# Define individual local variables to hold values for easy reference
locals {
  config = yamldecode(file("variables.yml"))

  namespace         = local.config["namespace"]
  environment       = local.config["environment"]
  region            = local.config["region"]
  oidc_provider_url = local.config["oidc_provider_url"]


  # VPC
  vpc_config       = local.config["vpc"]
  vpc_cidr_block   = local.vpc_config["vpc_cidr_block"]
  azs              = local.vpc_config["azs"]
  public_subnets   = local.vpc_config["public_subnets"]
  private_subnets  = local.vpc_config["private_subnets"]
  database_subnets = local.vpc_config["database_subnets"]


  # ECS Deployment
  ecs_config                                  = local.config["app_deployment"]
  instance_type                               = local.ecs_config["instance_type"]
  containers                                  = local.ecs_config["containers"]
  ecs_task_deployment_minimum_healthy_percent = local.ecs_config["ecs_task_deployment_minimum_healthy_percent"]
  ecs_task_deployment_maximum_percent         = local.ecs_config["ecs_task_deployment_maximum_percent"]
  maximum_scaling_step_size                   = local.ecs_config["maximum_scaling_step_size"]
  minimum_scaling_step_size                   = local.ecs_config["minimum_scaling_step_size"]
  asg_ec2_target_capacity                     = local.ecs_config["asg_ec2_target_capacity"]
  cw_logs_retention_in_days                   = local.ecs_config["cw_logs_retention_in_days"]
  ec2_autoscaling_max_size                    = local.ecs_config["ec2_autoscaling_max_size"]
  ec2_autoscaling_min_size                    = local.ecs_config["ec2_autoscaling_min_size"]
  ec2_desired_capacity                        = local.ecs_config["ec2_desired_capacity"]
  aws_acm_certificate_arn                     = local.ecs_config["aws_acm_certificate_arn"]
  launch_type                                 = local.ecs_config["launch_type"]
  enable_cross_zone_load_balancing            = local.ecs_config["enable_cross_zone_load_balancing"]


  # RDS
  rds_config                          = local.config["rds"]
  identifier                          = local.rds_config["identifier"]
  engine                              = local.rds_config["engine"]
  engine_version                      = local.rds_config["engine_version"]
  instance_class                      = local.rds_config["instance_class"]
  allocated_storage                   = local.rds_config["allocated_storage"]
  db_name                             = local.rds_config["db_name"]
  username                            = local.rds_config["username"]
  port                                = local.rds_config["port"]
  iam_database_authentication_enabled = local.rds_config["iam_database_authentication_enabled"]
  create_monitoring_role              = local.rds_config["create_monitoring_role"]
  create_db_subnet_group              = local.rds_config["create_db_subnet_group"]
  family                              = local.rds_config["family"]
  major_engine_version                = local.rds_config["major_engine_version"]
  deletion_protection                 = local.rds_config["deletion_protection"]

  # BACKUP VAULT
  backup_vault_config           = local.config["backup_vault_svc"]
  backup_vault_name             = local.backup_vault_config["backup_vault_name"]
  backup_service_selection_name = local.backup_vault_config["backup_service_selection_name"]
  bp_name                       = local.backup_vault_config["bp_name"]
  bp_rule_schedule              = local.backup_vault_config["bp_rule_schedule"]
  delete_after                  = local.backup_vault_config["delete_after"]
  schedule_expression_timezone  = local.backup_vault_config["schedule_expression_timezone"]
  start_window                  = local.backup_vault_config["start_window"]
  completion_window             = local.backup_vault_config["completion_window"]
  bp_rule_name                  = local.backup_vault_config["bp_rule_name"]

  # Tags
  common_tags = local.config["common_tags"]
}
