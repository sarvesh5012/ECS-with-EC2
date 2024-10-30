########################################################################################################################


########################################################################################################################
## Launch template for all EC2 instances that are part of the ECS cluster
########################################################################################################################

resource "aws_launch_template" "ecs_launch_template" {
  count = var.launch_type == "ec2" ? 1 : 0
  name                   = "${var.namespace}_EC2_LaunchTemplate_${var.environment}"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.default.key_name
  user_data              = base64encode(data.template_file.user_data.rendered)
  vpc_security_group_ids = [aws_security_group.ec2.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
  }

  monitoring {
    enabled = true
  }

  tags = {
    Scenario = var.scenario
  }
}

data "template_file" "user_data" {
  template = file("module/user_data.sh")

  vars = {
    ecs_cluster_name = aws_ecs_cluster.default.name
  }
}
