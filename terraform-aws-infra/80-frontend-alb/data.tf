data "aws_ssm_parameter" "frontend_alb_id" {
name = "/${var.project}/${var.environment}/frontend-alb_sg_id"
}
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project}/${var.environment}/public_subnet_id"
}
data "aws_route53_zone" "zone_id" {
  name         = "daws86s-akhil.shop"
  private_zone = false
}
data "aws_ssm_parameter" "certificate_arn" {
    name = "/${var.project}/${var.environment}-cert-arn"
}