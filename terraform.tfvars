# terraform.tfvars
namespace           = "virtue"
domain_name         = "virtues.agency"
service_name        = "my-service"
scenario            = "scenario-ecs-ec2"
environment         = "dev"
region              = "ap-southeast-1"
vpc_cidr_block      = "10.1.0.0/16"
az_count            = 2
public_ec2_key      = "my-key-pair"
instance_type       = "t3.micro"
ecs_task_desired_count = 2
containers = [
  {
    name           = "nginx-container"
    image_uri      = "nginx"
    container_port = 80
    cpu_units      = 2048
    memory         = 8192
  },
  {
    name           = "app-container"
    image_uri      = "httpd"
    container_port = 80
    cpu_units      = 1024
    memory         = 4096
  }
]

retention_in_days      = 7
autoscaling_max_size   = 6
autoscaling_min_size   = 2
custom_origin_host_header = "dev"
healthcheck_endpoint   = "/"
healthcheck_matcher    = "200"
aws_acm_certificate_arn = "arn:aws:acm:ap-southeast-1:7123456789:certificate/50a1d91f-b79c-4565-8e4f-fd6e0cc8e7b2"
