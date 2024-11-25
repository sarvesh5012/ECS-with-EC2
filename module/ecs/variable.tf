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


# EC2 Computing variables


variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t3.micro"
  type        = string
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

variable "asg_ec2_target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}


# Cloudwatch

variable "cw_logs_retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}


# Autoscaling Group

variable "ec2_autoscaling_max_size" {
  description = "Max size of the autoscaling group"
  default     = 6
  type        = number
}

variable "ec2_desired_capacity" {
  description = "Provide desired capacity count"
  default     = 2
  type        = number
}

variable "ec2_autoscaling_min_size" {
  description = "Min size of the autoscaling group"
  default     = 2
  type        = number
}

# ALB


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

# variable "common_tags" {
#   type = map(string)
# }

variable "containers" {
  type    = map(any)
  default = {}
}