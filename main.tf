# main.tf
module "ecs_infrastructure" {
  source = "./module"

  # Service variables
  namespace           = var.namespace
  domain_name         = var.domain_name
  service_name        = var.service_name
  scenario            = var.scenario
  environment         = var.environment

  # AWS credentials
  region              = var.region

  # Network variables
  vpc_cidr_block      = var.vpc_cidr_block
  az_count            = var.az_count

  # EC2 Computing variables
  public_ec2_key      = var.public_ec2_key
  instance_type       = var.instance_type

  # ECS containers configuration
  containers          = var.containers  # Pass the containers variable to the module

  # Cloudwatch
  retention_in_days   = var.retention_in_days

  # Autoscaling Group
  autoscaling_max_size = var.autoscaling_max_size
  autoscaling_min_size = var.autoscaling_min_size

  # ALB
  custom_origin_host_header = var.custom_origin_host_header
  healthcheck_endpoint      = var.healthcheck_endpoint
  healthcheck_matcher       = var.healthcheck_matcher
  aws_acm_certificate_arn   = var.aws_acm_certificate_arn
}
