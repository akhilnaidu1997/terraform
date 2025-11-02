resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb" #roboshop-dev-backend_alb
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, This is fixed content for testing"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
}

