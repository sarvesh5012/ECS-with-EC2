# Create log group for our service

resource "aws_cloudwatch_log_group" "log_group" {
  for_each          = var.containers
  name              = "/${lower(var.namespace)}/ecs/${each.key}"
  retention_in_days = var.cw_logs_retention_in_days


}
