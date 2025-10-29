data "aws_ssm_parameter" "backend_alb_id" {
name = "/${var.project}/${var.environment}/backend-alb_sg_id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_id"
}