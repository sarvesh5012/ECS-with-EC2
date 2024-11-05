# Fargate ECS Service
resource "aws_ecs_service" "fargate_service" {
  count = var.launch_type == "fargate" ? 1 : 0
  name                               = "${var.namespace}_ECS_Service_${var.environment}"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.fargate_default[0].arn  # Indexed for Fargate
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.fargate_service_target_group[0].arn
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

#########Outputs###########

# Output for Fargate ECS Service
# output "ecs_service_fargate_name" {
#   value = aws_ecs_service.service.name
# }
