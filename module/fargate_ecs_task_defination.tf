# Fargate

resource "aws_ecs_task_definition" "fargate_default" {
  # count = var.launch_type == "fargate" ? 1 : 0
  for_each =var.containers
  family                   = "${each.value.service_name}_Tdf_${var.environment}"

  network_mode             = var.launch_type == "FARGATE" ? "awsvpc" : "bridge"

  requires_compatibilities = ["${var.launch_type}"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = var.launch_type == "EC2" ? aws_iam_role.ecs_task_iam_role.arn : null
  cpu                      = each.value.cpu_units
  memory                   = each.value.memory

  container_definitions = jsonencode([
    {
      name         = each.value.service_name
      image        = each.value.image_uri
      cpu          = each.value.cpu_units
      memory       = each.value.memory
      essential    = true
      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group["${each.key}"].name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${each.value.service_name}-log-stream-${var.environment}"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}
