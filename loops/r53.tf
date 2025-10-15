resource "aws_route53_record" "roboshop" {
  count = 2
  zone_id = var.zone_id
  name    = "${var.instance[count.index]}.${var.domain_name}" #mongodb.daws86s-akhil.shop
  type    = "A"
  ttl     = 1
  records = [aws_instance.instance[count.index].private_ip]
  allow_overwrite = true
}