# Bastion host SG and EC2 Instance

resource "aws_security_group" "bastion_host" {
  count = var.launch_type == "EC2" ? 1 : 0
  name        = "${var.namespace}_SecurityGroup_BastionHost_${var.environment}"
  description = "Bastion host Security Group"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

   
}

resource "aws_instance" "bastion_host" {
  count = var.launch_type == "EC2" ? 1 : 0
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  key_name                    = "KEY00"
  vpc_security_group_ids      = [aws_security_group.bastion_host[0].id]

  tags = merge({
    Name     = "${var.namespace}_EC2_BastionHost_${var.environment}"
  }, var.tags)
}
