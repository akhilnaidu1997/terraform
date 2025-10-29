data "aws_ssm_parameter" "bastion_sg_id" {
name = "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "backend_alb_id" {
name = "/${var.project}/${var.environment}/backend-alb_sg_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
name = "/${var.project}/${var.environment}/mongodb_sg_id"
}