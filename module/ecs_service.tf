# EC2 ECS Service
resource "aws_ecs_service" "ec2_service" {
  # count = var.launch_type == "EC2" ? 1 : 0
  for_each = var.containers
  name                               = "${each.value.service_name}"
  iam_role                            = var.launch_type == "EC2" ? aws_iam_role.ecs_service_role[each.key].arn : null
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.fargate_default["${each.key}"].arn  # Indexed for EC2
  desired_count                      = each.value.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = var.launch_type == "FARGATE" ? "FARGATE" : null

  load_balancer {
    target_group_arn = aws_alb_target_group.ec2_service_target_group["${each.key}"].arn
    container_name   = each.value.service_name
    container_port   = each.value.container_port
  }

  capacity_provider_strategy {
    for_each = var.launch_type == "EC2" ? 1 : 0
    base              = 2
    capacity_provider = aws_ecs_capacity_provider.cas[0].name
    weight            = 50
  }

  #network_configuration {
  #  security_groups  = [aws_security_group.ecs_container_instance["${each.key}"].id]  # Indexed for Fargate
  #  subnets          = aws_subnet.private[*].id
  #  assign_public_ip = false
  #}

  # Conditionally include network configuration only for FARGATE
  dynamic "network_configuration" {
    for_each = var.launch_type == "FARGATE" ? [1] : []
    content {
      security_groups  = [aws_security_group.ecs_container_instance[each.key].id]
      subnets          = aws_subnet.private[*].id
      assign_public_ip = false
    }
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_security_group.ecs_container_instance]
}





#########Outputs###########

# Output for EC2 ECS Service
# output "ecs_service_name" {
#   value = var.launch_type == "EC2" ? aws_ecs_service.service.name : null
# }

