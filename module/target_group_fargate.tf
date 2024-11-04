## Target Group for our fargate service
########################################################################################################################

resource "aws_alb_target_group" "service_target_group" {
  name                 = "${var.namespace}-TargetGroup-${var.environment}"
  port                 = container.container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

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