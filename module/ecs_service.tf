# EC2 ECS Service
resource "aws_ecs_service" "service" {
  count = var.launch_type == "ec2" ? 1 : 0
  name                               = "${var.namespace}_ECS_Service_${var.environment}"
  iam_role                           = aws_iam_role.ecs_service_role.arn
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.default[0].arn  # Indexed for EC2
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target_group.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    Scenario = var.scenario
  }
}



# Fargate ECS Service
resource "aws_ecs_service" "service_fargate" {
  count = var.launch_type == "fargate" ? 1 : 0
  name                               = "${var.namespace}_ECS_Service_${var.environment}"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.default_fargate[0].arn  # Indexed for Fargate
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target_group.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_container_instance[0].id]  # Indexed for Fargate
    subnets          = aws_subnet.private[*].id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}

#################Outputs#####################

# Output for EC2 ECS Service
output "ecs_service_name" {
  value = var.launch_type == "ec2" ? aws_ecs_service.service[0].name : null
}

# Output for Fargate ECS Service
output "ecs_service_fargate_name" {
  value = var.launch_type == "fargate" ? aws_ecs_service.service_fargate[0].name : null
}
