locals {
  ami_id = data.aws_ami.data_source.id
}
locals {
  #bastion = data.aws_ssm_parameter.bastion_sg_id.value
  common_name = "${var.project}-${var.environment}"
  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "True"
  }
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)
  sg_id = data.aws_ssm_parameter.sg_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  arn = "${var.component}" == "frontend" ?  data.aws_ssm_parameter.listener_arn_frontend.value : data.aws_ssm_parameter.listener_arn.value
  tg_port = "${var.component}" == "frontend" ? 80 : 8080
  health_check_path = "${var.component}" == "frontend" ? "/" : "/health"
  host_context = "${var.component}" == "frontend" ? "${var.project}-${var.environment}.${var.domain}" : "${var.component}.backend-alb-${var.environment}.${var.domain}"
}