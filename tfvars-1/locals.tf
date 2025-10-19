locals {
  common_names = "${var.project}-${var.env}"
  common_tags = {
    project = var.project
    Terraform = "True"
  }
}