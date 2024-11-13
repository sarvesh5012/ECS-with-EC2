# Application Load Balancer in public subnets with HTTP default listener that redirects traffic to HTTPS

resource "aws_alb" "alb" {
  name            = "${var.namespace}-ALB-${var.environment}"
  security_groups = [aws_security_group.alb.id]
  subnets         = aws_subnet.public.*.id

  tags = {
    Scenario = var.scenario
  }
}

resource "aws_lb_listener" "alb_http" {
    load_balancer_arn = aws_alb.alb.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
    type = "redirect"
    redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
        }
    }
}



# Default HTTPS listener that blocks all traffic without valid custom origin header

resource "aws_alb_listener" "alb_default_listener_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.aws_acm_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Access denied"
      status_code  = "403"
    }
  }

  tags = {
    Scenario = var.scenario
  }

  # depends_on = [aws_acm_certificate.alb_certificate]
}




resource "aws_alb_listener_rule" "ec2_https_listener_rule" {
  # count = var.launch_type == "EC2" ? 1 : 0
  for_each = var.containers
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ec2_service_target_group["${each.key}"].arn
  }

  condition {
    host_header {
      values = ["${each.value.custom_origin_host_header}"]
    }
  }

  

  tags = {
    Scenario = var.scenario
  }
}


