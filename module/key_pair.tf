# Create a public and private key pair for login to the EC2 Instances

data "aws_key_pair" "example" {
  key_name           = "KEY00"
  include_public_key = true

  filter {
    name   = "tag:env"
    values = ["dev"]
  }
}

output "fingerprint" {
  value = data.aws_key_pair.example.fingerprint
}

output "name" {
  value = data.aws_key_pair.example.key_name
}

output "id" {
  value = data.aws_key_pair.example.id
}

# resource "tls_private_key" "example" {
#   count = var.launch_type == "ec2" ? 1 : 0
#   algorithm = "RSA"
#   rsa_bits  = 2048
#  }

# resource "aws_key_pair" "default" {
#   count = var.launch_type == "ec2" ? 1 : 0
#   key_name   = "${var.namespace}_KeyPair_${var.environment}"
#   public_key = tls_private_key.example[0].public_key_openssh

#   tags = {
#     Scenario = var.scenario
#   }
# }

# output "private_key_pem" {
#   value     = tls_private_key.example.private_key_pem
#   sensitive = true
# }

# output "key_name" {
#   value = data.aws_key_pair.example.key_name
# }
