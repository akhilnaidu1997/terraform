variable "instance_type" {
    default = "t2.micro"
  
}
variable "project" {
    default = "Roboshop"
}
variable "env" {
    default = "dev"
}
# variable "common_name" {
#     default = "${var.project}-${var.env}"
# }
variable "ec2_tags" {
    default = {
        project = "Roboshop"
        env = "dev"
        Terraform = "True"
    }
  
}