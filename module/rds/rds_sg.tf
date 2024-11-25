resource "aws_security_group" "rds" {
  
  vpc_id = data.aws_subnet.db_subnet.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ingress {
  #  from_port   = 5432
  # to_port     = 5432
  #  protocol    = "tcp"
  #  security_groups = ["sg-0831743d2ff0706b4"]
  # }

  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # tags = merge({
  #   Name = "${var.namespace}_RDS_security_group${var.environment}"
  # }, var.common_tags)
}

