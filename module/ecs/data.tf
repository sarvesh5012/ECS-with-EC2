# Get most recent AMI for an ECS-optimized Amazon Linux 2 instance

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}



# Subnet

data "aws_subnet" "public_subnet_id" {
  id = var.public_subnet_ids[0]
}


# region
# Data block to fetch the AWS region
data "aws_region" "current" {}

# Output the fetched region
output "current_region" {
  value = data.aws_region.current.name
}
