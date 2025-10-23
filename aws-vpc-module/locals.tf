locals {
  common_name_suffix = "${var.project}-${var.environment}"
  common_tags = {
    Project = var.project
    Terraform = "True"
    Environment = var.environment
  }
  az_names = slice(data.aws_availability_zones.available.names,0,2)
}