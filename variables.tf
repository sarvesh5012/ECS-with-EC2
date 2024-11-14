# Service variables

variable "namespace" {
  description = "Namespace for resource names"
  default     = "ecs"
  type        = string
}

# variable "domain_name" {
#   description = "Domain name of the service (like service.example.com)"
#   type        = string
# }

# variable "service_name" {
#   description = "A Docker image-compatible name for the service"
#   type        = string
# }

variable "scenario" {
  description = "Scenario name for tags"
  default     = "scenario-ecs-ec2"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "dev"
  type        = string
}

# AWS credentials



variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
  type        = string
}

# Network variables

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.1.0.0/16"
  type        = string
}

variable "az_count" {
  description = "Describes how many availability zones are used"
  default     = 2
  type        = number
}

# EC2 Computing variables

# variable "public_ec2_key" {
#   description = "Public key for SSH access to EC2 instances"
#   type        = string
# }

variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t3.micro"
  type        = string
}

# ECS variables

# variable "ecs_task_desired_count" {
#   description = "How many ECS tasks should run in parallel"
#   type        = number
# }

variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  default     = 10
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 70
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 80
  type        = number
}

variable "maximum_scaling_step_size" {
  description = "Maximum amount of EC2 instances that should be added on scale-out"
  default     = 5
  type        = number
}

variable "minimum_scaling_step_size" {
  description = "Minimum amount of EC2 instances that should be added on scale-out"
  default     = 1
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

# variable "container_port" {
#   description = "Port of the container"
#   type        = number
#   default     = 3000
# }

# variable "cpu_units" {
#   description = "Amount of CPU units for a single ECS task"
#   default     = 100
#   type        = number
# }

# variable "memory" {
#   description = "Amount of memory in MB for a single ECS task"
#   default     = 256
#   type        = number
# }

# Cloudwatch

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}

# ECR


# variable "image_uri" {
#   description = "nginx"
#   type        = string
# }

# Autoscaling Group

variable "autoscaling_max_size" {
  description = "Max size of the autoscaling group"
  default     = 6
  type        = number
}

variable "desired_capacity"  {
  description = "Provide desired capacity count"
  default     = 2
  type        = number
}    

variable "autoscaling_min_size" {
  description = "Min size of the autoscaling group"
  default     = 2
  type        = number
}

# ALB

# variable "custom_origin_host_header" {
#   description = "Custom header to ensure communication only through CloudFront"
#   default     = "dev"
#   type        = string
# }

variable "healthcheck_endpoint" {
  description = "Endpoint for ALB healthcheck"
  type        = string
  default     = "/"
}

variable "healthcheck_matcher" {
  description = "HTTP status code matcher for healthcheck"
  type        = string
  default     = "200"
}


variable "aws_acm_certificate_arn" {
  description = "Provide aws acm certificate"
  type = string
  
}


variable "launch_type" {
  type = string
}

variable "containers" {
  type = map(any)
  default = {}
}



locals {
  yaml_vars = yamldecode(file("variables.yaml"))
}

# Use the YAML variables
variable "namespace" { default = local.yaml_vars["namespace"] }
variable "scenario" { default = local.yaml_vars["scenario"] }
variable "environment" { default = local.yaml_vars["environment"] }
variable "region" { default = local.yaml_vars["region"] }
variable "vpc_cidr_block" { default = local.yaml_vars["vpc_cidr_block"] }
variable "az_count" { default = local.yaml_vars["az_count"] }
variable "instance_type" { default = local.yaml_vars["instance_type"] }
variable "containers" { default = local.yaml_vars["containers"] }
variable "ecs_task_min_count" { default = local.yaml_vars["ecs_task_min_count"] }
variable "ecs_task_max_count" { default = local.yaml_vars["ecs_task_max_count"] }
variable "ecs_task_deployment_minimum_healthy_percent" { default = local.yaml_vars["ecs_task_deployment_minimum_healthy_percent"] }
variable "ecs_task_deployment_maximum_percent" { default = local.yaml_vars["ecs_task_deployment_maximum_percent"] }
variable "cpu_target_tracking_desired_value" { default = local.yaml_vars["cpu_target_tracking_desired_value"] }
variable "memory_target_tracking_desired_value" { default = local.yaml_vars["memory_target_tracking_desired_value"] }
variable "maximum_scaling_step_size" { default = local.yaml_vars["maximum_scaling_step_size"] }
variable "minimum_scaling_step_size" { default = local.yaml_vars["minimum_scaling_step_size"] }
variable "target_capacity" { default = local.yaml_vars["target_capacity"] }
variable "retention_in_days" { default = local.yaml_vars["retention_in_days"] }
variable "autoscaling_max_size" { default = local.yaml_vars["autoscaling_max_size"] }
variable "autoscaling_min_size" { default = local.yaml_vars["autoscaling_min_size"] }
variable "desired_capacity" { default = local.yaml_vars["desired_capacity"] }
variable "healthcheck_endpoint" { default = local.yaml_vars["healthcheck_endpoint"] }
variable "healthcheck_matcher" { default = local.yaml_vars["healthcheck_matcher"] }
variable "aws_acm_certificate_arn" { default = local.yaml_vars["aws_acm_certificate_arn"] }
variable "launch_type" { default = local.yaml_vars["launch_type"] }
