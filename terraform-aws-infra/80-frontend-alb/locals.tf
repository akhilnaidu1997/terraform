locals {
  common_name_suffix = "${var.project}-${var.environment}"
  frontend_alb_id = data.aws_ssm_parameter.frontend_alb_id.value
  public_subnet_ids = split(",",data.aws_ssm_parameter.public_subnet_ids.value)
  certificate_arn = data.aws_ssm_parameter.certificate_arn.value
  common_tags = {
    project = var.project
    environment = var.environment
    Terraform = "True"
  }
}