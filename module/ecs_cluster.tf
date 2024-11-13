# Creates an ECS Cluster

resource "aws_ecs_cluster" "default" {
  name = "${var.namespace}_ECSCluster_${var.environment}"

  # default_capacity_provider_strategy {
  #   base              = 20
  #   capacity_provider = "virtue_ECS_CapacityProvider_dev"
  #   weight            = 60
  #   }

  tags = {
    Name     = "${var.namespace}_ECSCluster_${var.environment}"
    Scenario = var.scenario
  }
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}
