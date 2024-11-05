# Target Group for our service

resource "aws_alb_target_group" "ec2_service_target_group" {
  # count = var.launch_type == "ec2" ? 1 : 0
  for_each = var.containers
  name                 = "${var.namespace}-TargetGroup-${var.environment}"
  port                 = esch.value.container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type = var.launch_type == "FARGATE" ? "ip" : "instance"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}