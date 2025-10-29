locals {
  common_name_suffix = "${var.project}-${var.environment}"
  backend_alb_id = data.aws_ssm_parameter.backend_alb_id.value
  private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
}