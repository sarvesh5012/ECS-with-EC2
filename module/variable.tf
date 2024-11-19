# Service variables

variable "namespace" {
  description = "Namespace for resource names"
  default     = "ecs"
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
  default     = "eu-central-1"
  type        = string
}

# Network variables


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.1.0.0/16"
  type        = string
}


variable "private_subnet_ids" {
  description = "Get the Private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Get the Public subnet IDs"
  type        = list(string)
}

variable "azs" {
  description = "Provide Availibility zones in list"
  type        = list(string)
}

variable "public_subnets" {
  description = "Provide Public subnets CIDR in list"
  type        = list(string)
}

variable "private_subnets" {
  description = "Provide Private subnets CIDR list"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
}

# EC2 Computing variables


variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t3.micro"
  type        = string
}



variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  #default     = 10
  type = number
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


# Cloudwatch

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}


# Autoscaling Group

variable "autoscaling_max_size" {
  description = "Max size of the autoscaling group"
  default     = 6
  type        = number
}

variable "desired_capacity" {
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

variable "healthcheck_matcher" {
  description = "HTTP status code matcher for healthcheck"
  type        = string
  default     = "200"
}

variable "enable_cross_zone_load_balancing" {
  description = "Used for the multi-az deployment"
  type        = bool
  default     = false
}

variable "aws_acm_certificate_arn" {
  description = "Provide aws acm certificate"
  type        = string

}


variable "launch_type" {
  type    = string
  default = "fargate"
}

variable "tags" {
  type = map(string)
}

variable "containers" {
  type    = map(any)
  default = {}
}