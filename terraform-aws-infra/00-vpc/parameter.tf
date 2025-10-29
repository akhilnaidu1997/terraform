resource "aws_ssm_parameter" "vpc_id" {
  name  = local.common_name
  type  = "String"
  value = module.vpc.vpc_out
}
resource "aws_ssm_parameter" "public_subnet" {
  name  = local.public_subnet
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_ids)
}
resource "aws_ssm_parameter" "private_subnet" {
  name  = local.private_subnet
  type  = "StringList"
  value = join(",", module.vpc.private_subnet_ids)
}
resource "aws_ssm_parameter" "database_subnet" {
  name  = local.database_subnet
  type  = "StringList"
  value = join(",", module.vpc.database_subnet_ids)
}