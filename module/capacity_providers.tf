# Creates Capacity Provider linked with ASG and ECS Cluster

resource "aws_ecs_capacity_provider" "cas" {
  count = var.launch_type == "EC2" ? 1 : 0
  name = "${var.namespace}_ECS_CapacityProvider_${var.environment}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_autoscaling_group[0].arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }
  }

  tags = {
    Scenario = var.scenario
  }
}

resource "aws_ecs_cluster_capacity_providers" "cas" {
  count = var.launch_type == "EC2" ? 1 : 0
  cluster_name       = aws_ecs_cluster.default.name
  capacity_providers = [aws_ecs_capacity_provider.cas[0].name]

  default_capacity_provider_strategy {
    base              = 20
    capacity_provider = aws_ecs_capacity_provider.cas[0].name
    weight            = 60
  }
}
