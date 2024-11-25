# Target Group for our service

resource "aws_alb_target_group" "ec2_service_target_group" {
  # count = var.launch_type == "EC2" ? 1 : 0
  for_each             = var.containers
  name                 = "${each.key}-${var.environment}"
  port                 = each.value.container_port
  protocol             = "HTTP"
  vpc_id               = data.aws_subnet.public_subnet_id.vpc_id
  deregistration_delay = 5
  target_type          = var.launch_type == "FARGATE" ? "ip" : "instance"
  health_check {
    enabled             = each.value.health_check_enabled
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    # matcher             = var.healthcheck_matcher
    path                = each.value.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }



  depends_on = [aws_alb.alb]
}
