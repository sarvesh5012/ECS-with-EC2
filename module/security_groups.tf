########################################################################################################################
## SG for EC2 instances
########################################################################################################################

resource "aws_security_group" "ec2" {
  name        = "${var.namespace}_EC2_Instance_SecurityGroup_${var.environment}"
  description = "Security group for EC2 instances in ECS cluster"
  vpc_id      = aws_vpc.default.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
    from_port       = 1024
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description     = "Allow SSH ingress traffic from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}_EC2_Instance_SecurityGroup_${var.environment}"
    Scenario = var.scenario
  }
}

########################################################################################################################
## SG for ALB
########################################################################################################################

resource "aws_security_group" "alb" {
  name        = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.default.id

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
    Scenario = var.scenario
  }
}

########################################################################################################################
## We only allow incoming traffic on HTTPS from known CloudFront CIDR blocks
########################################################################################################################

data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_security_group_rule" "alb_cloudfront_https_ingress_only" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTPS access only from CloudFront CIDR blocks"
  from_port         = 443
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  to_port           = 443
  type              = "ingress"
}


## SG for ECS Container Instances
########################################################################################################################

resource "aws_security_group" "ecs_container_instance" {
  name        = "${var.namespace}_ECS_Task_SecurityGroup_${var.environment}"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = aws_vpc.default.id

  #ingress {
    #description     = "Allow ingress traffic from ALB on HTTP only"
    #from_port       = var.container_port
    #to_port         = var.container_port
    #protocol        = "tcp"
    #security_groups = [aws_security_group.alb.id]
  #}
  dynamic "ingress" {
    for_each = var.containers
    description     = "Allow ingress traffic from ALB on HTTP only"
    content {
      from_port   = ingress.value.container_port
      to_port     = ingress.value.container_port
      protocol    = "tcp"
      
    }
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}_ECS_Task_SecurityGroup_${var.environment}"
    Scenario = var.scenario
  }
}