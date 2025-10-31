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
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  
}