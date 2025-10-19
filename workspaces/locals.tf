locals {
  common_names = "${var.project}-${terraform.workspace}"
  common_tags = {
    Terraform = "True"
    Project =  var.project
  }
}