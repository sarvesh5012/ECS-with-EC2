# Define Target Tracking on ECS Cluster Task level

# resource "aws_appautoscaling_target" "fargate_ecs_target" {
#   count = var.launch_type == "fargate" ? 1 : 0
#   max_capacity       = var.ecs_task_max_count
#   min_capacity       = var.ecs_task_min_count
#   resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.fargate_service[0].name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

resource "aws_appautoscaling_target" "ec2_ecs_target" {
  # count = var.launch_type == "EC2" ? 1 : 0
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.ec2_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# Policy for CPU tracking

# resource "aws_appautoscaling_policy" "fargate_ecs_cpu_policy" {
#   count = var.launch_type == "fargate" ? 1 : 0
#   name               = "${var.namespace}_CPUTargetTrackingScaling_${var.environment}"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.fargate_ecs_target[0].resource_id
#   scalable_dimension = aws_appautoscaling_target.fargate_ecs_target[0].scalable_dimension
#   service_namespace  = aws_appautoscaling_target.fargate_ecs_target[0].service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = var.cpu_target_tracking_desired_value

#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#   }
# }

resource "aws_appautoscaling_policy" "ec2_ecs_cpu_policy" {
  # count = var.launch_type == "EC2" ? 1 : 0
  name               = "${var.namespace}_CPUTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ec2_ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ec2_ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ec2_ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

# Policy for memory tracking

resource "aws_appautoscaling_policy" "ec2_ecs_targetecs_memory_policy" {
  # count = var.launch_type == "EC2" ? 1 : 0
  name               = "${var.namespace}_MemoryTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ec2_ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ec2_ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ec2_ecs_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

# resource "aws_appautoscaling_policy" "fargate_ecs_memory_policy" {
#   count = var.launch_type == "fargate" ? 1 : 0
#   name               = "${var.namespace}_MemoryTargetTrackingScaling_${var.environment}"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.fargate_ecs_target[0].resource_id
#   scalable_dimension = aws_appautoscaling_target.fargate_ecs_target[0].scalable_dimension
#   service_namespace  = aws_appautoscaling_target.fargate_ecs_target[0].service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = var.memory_target_tracking_desired_value

#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#     }
#   }
# }