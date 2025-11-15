module "components" {
    for_each = var.components
    source = "../../terraform-roboshop-components"
    component = each.key
    instance_type = var.instance_type
    priority = each.value.priority
}

resource "aws_route53_record" "records" {
  for_each = module.components
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "${each.key}-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.each.key.private_ip]
  allow_overwrite = true 
}