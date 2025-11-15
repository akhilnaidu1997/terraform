data "aws_ami" "data_source" {
  most_recent = true
  owners      = ["973714476881"]
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ssm_parameter" "sg_id" {
name = "/${var.project}/${var.environment}/${var.component}_sg_id"
}

data "aws_ssm_parameter" "private_subnet_id" {
name = "/${var.project}/${var.environment}/private_subnet_id"
}

data "aws_ssm_parameter" "listener_arn" {
name = "/${var.project}/${var.environment}/listener_arn"
}

data "aws_ssm_parameter" "listener_arn_frontend" {
name = "/${var.project}/${var.environment}/listener_arn_frontend"
}

data "aws_ssm_parameter" "vpc_id" {
name = "/${var.project}/${var.environment}/vpc_id"
}

