# Creates an ECS Cluster

resource "aws_ecs_cluster" "default" {
  name = "${var.namespace}_ECSCluster_${var.environment}"

  dynamic "default_capacity_provider_strategy" {
    for_each = var.launch_type == "EC2" ? [1] : []
    content{
    base              = 20
    capacity_provider = aws_ecs_capacity_provider.cas[0].name
    weight            = 60
    }
    }

  tags = {
    Name     = "${var.namespace}_ECSCluster_${var.environment}"
    Scenario = var.scenario
  }
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}
