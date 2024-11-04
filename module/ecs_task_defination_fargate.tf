# Fargate


resource "aws_ecs_task_definition" "default" {
  family                   = "${var.namespace}_ECS_TaskDefinition_${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    for container in var.containers : {
      name         = container.name
      image        = container.image_uri
      cpu          = container.cpu
      memory       = container.memory
      essential    = container.essential
      portMappings = [
        {
          containerPort = container.container_port
          hostPort      = container.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${container.name}-log-stream-${var.environment}"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}
