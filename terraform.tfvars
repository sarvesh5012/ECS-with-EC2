# Service variables
#namespace           = "virtue"
domain_name         = "virtues.agency"
#service_name        = "my-service"
scenario            = "scenario-ecs-ec2"
#environment         = "dev"
# AWS credentials
region                = "ap-southeast-1"
# Network variables
vpc_cidr_block   = "10.1.0.0/16"
az_count         = 2
# EC2 Computing variables
public_ec2_key   = "my-key-pair"
instance_type    = "t3.micro"
# ECS variables
#ecs_task_desired_count  
containers = {
  container_1 = { 
    namespace           = "virtue"
    ecs_task_desired_count                         = 1
    service_name           = "nginx-container"
    image_uri      = "nginx"
    container_port = 80
    cpu_units      = 2048
    memory         = 8192
    environment         = "dev"
  },
  container_2 = {
    namespace           = "Abc"
    ecs_task_desired_count                         = 1
    service_name           = "app-container"
    image_uri      = "httpd"
    container_port = 80
    cpu_units      = 1024
    memory         = 4096
    environment         = "dev"
  }
}

ecs_task_min_count                             = 2
ecs_task_max_count                             = 10
ecs_task_deployment_minimum_healthy_percent    = 50
ecs_task_deployment_maximum_percent            = 100
cpu_target_tracking_desired_value              = 70
memory_target_tracking_desired_value           = 80
maximum_scaling_step_size                      = 5
minimum_scaling_step_size                      = 1
target_capacity                                = 100
#container_port                                 = 80
#cpu_units                                      = 2048
#memory                                         = 8192

# Cloudwatch
retention_in_days  = 7

# ECR

#image_uri     = "nginx"

# Autoscaling Group
autoscaling_max_size  = 6
autoscaling_min_size  = 2

# ALB
custom_origin_host_header  = "dev"
healthcheck_endpoint       = "/"
healthcheck_matcher        = "200"
aws_acm_certificate_arn        = "arn:aws:acm:ap-southeast-1:711387124065:certificate/50a1d91f-b79c-4565-8e4f-fd6e0cc8e7b2"
