

# Launch template for all EC2 instances that are part of the ECS cluster

resource "aws_launch_template" "ecs_launch_template" {
  count = var.launch_type == "EC2" ? 1 : 0
  name                   = "${var.namespace}_EC2_LaunchTemplate_${var.environment}"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = "KEY00"
  user_data              = base64encode(data.template_file.user_data.rendered)
  #vpc_security_group_ids = [aws_security_group.ecs_container_instance[count.index].id]
  vpc_security_group_ids = values(aws_security_group.ecs_container_instance)[*].id


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
