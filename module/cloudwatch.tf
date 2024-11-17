# Create log group for our service

resource "aws_cloudwatch_log_group" "log_group" {
  for_each = var.containers
  name              = "/${lower(var.namespace)}/ecs/${each.value.service_name}"
  retention_in_days = var.retention_in_days

   
}
