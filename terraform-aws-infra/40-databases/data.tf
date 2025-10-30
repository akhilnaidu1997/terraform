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

data "aws_ssm_parameter" "bastion_sg_id" {
name = "/${var.project}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "bastion_subnet_id" {
name = "/${var.project}/${var.environment}/public_subnet_id"
}

data "aws_ssm_parameter" "database_subnet_ids" {
name = "/${var.project}/${var.environment}/database_subnet_id"
}


