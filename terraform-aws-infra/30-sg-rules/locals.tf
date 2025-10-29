locals {
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  backend_alb_id = data.aws_ssm_parameter.backend_alb_id.value
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
}