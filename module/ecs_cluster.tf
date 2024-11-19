# Creates an ECS Cluster

resource "aws_ecs_cluster" "default" {
  name = "${var.namespace}_ECSCluster_${var.environment}"

  tags = merge({
    Name = "${var.namespace}_ECSCluster_${var.environment}"
  }, var.tags)
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}
