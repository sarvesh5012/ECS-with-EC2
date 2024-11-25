

# SG for ALB

resource "aws_security_group" "alb" {
  name        = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
  description = "Security group for ALB"
  vpc_id      = data.aws_subnet.public_subnet_id.vpc_id

  ingress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = merge({
  #   Name = "${var.namespace}_ALB_SecurityGroup_${var.environment}"
  # }, var.common_tags)
}




# SG for ECS Container Instances

resource "aws_security_group" "ecs_container_instance" {
  # count = var.launch_type == "FARGATE" ? 1 : 0
  for_each    = var.containers
  depends_on  = [aws_security_group.alb]
  name        = "${each.key}_sg_${var.environment}"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = data.aws_subnet.public_subnet_id.vpc_id

  ingress {
    description = "Allow ingress traffic from ALB on HTTP only"
    #from_port       = each.value.container_port
    #to_port         = each.value.container_port
    from_port       = 1024
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }


  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = merge({
  #   Name = "${var.namespace}_ECS_Task_SecurityGroup_${var.environment}"
  # }, var.common_tags)

}