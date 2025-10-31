locals {
  ami_id = data.aws_ami.data_source.id
}
locals {
  bastion = data.aws_ssm_parameter.bastion_sg_id.value
  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "True"
  }
  #ublic_subnet_ids = split(",", data.aws_ssm_parameter.b_subnet_id.value)[0]
  database_subnet_ids = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.id
}