resource "aws_lb" "frontend_alb" {
  name               = "${local.common_name_suffix}-frontend-alb" #roboshop-dev-backend_alb
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(
    local.common_tags,{
      Name = "${local.common_name_suffix}-frontend"
    }
  )
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
  certificate_arn   = local.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Fixed response content<h1>"
      status_code  = "200"
    }

  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "${var.project}-${var.environment}.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
}

