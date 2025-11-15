module "components" {
    for_each = var.components
    source = "../../terraform-roboshop-components"
    component = each.key
    instance_type = var.instance_type
    priority = each.value.priority
}

resource "aws_route53_record" "catalogue" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "catalogue.backend-alb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true 
}

resource "aws_route53_record" "user" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "user.backend-alb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.user.private_ip]
  allow_overwrite = true 
}

resource "aws_route53_record" "cart" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "cart.backend-alb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.cart.private_ip]
  allow_overwrite = true 
}

resource "aws_route53_record" "shipping" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "shipping.backend-alb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.shipping.private_ip]
  allow_overwrite = true 
}

resource "aws_route53_record" "payment" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "payment.backend-alb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.payment.private_ip]
  allow_overwrite = true 
}

