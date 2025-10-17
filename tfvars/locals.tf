locals {
  common_names = "${var.project}-${var.env}"
  common_tags = {
    Terraform = "True"
    Project =  var.project
  }
}