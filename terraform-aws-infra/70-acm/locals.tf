locals {
  common_name = "${var.project}-${var.environment}"
  zone_id = data.aws_route53_zone.zone_id.id
  common_tags = {
    project = var.project
    environment = var.environment
    Terraform = "True"
  }
}