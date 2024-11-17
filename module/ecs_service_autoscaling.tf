# Define Target Tracking on ECS Cluster Task level


resource "aws_appautoscaling_target" "ec2_ecs_target" {
  for_each = var.containers
  # count = var.launch_type == "EC2" ? 1 : 0
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${each.value.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  depends_on = [aws_ecs_service.ec2_service]
}

# Policy for CPU tracking


resource "aws_appautoscaling_policy" "ec2_ecs_cpu_policy" {
  # count = var.launch_type == "EC2" ? 1 : 0
  for_each = var.containers
  name               = "${var.namespace}_CPUTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].resource_id
  scalable_dimension = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = each.value.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

# Policy for memory tracking

resource "aws_appautoscaling_policy" "ec2_ecs_targetecs_memory_policy" {
  # count = var.launch_type == "EC2" ? 1 : 0
  for_each = var.containers
  name               = "${var.namespace}_MemoryTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].resource_id
  scalable_dimension = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ec2_ecs_target["${each.key}"].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = each.value.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

