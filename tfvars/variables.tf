variable "ami" {
    default = "ami-09c813fb71547fc4f"
}
variable "instance_type" {
    type = string
}
variable "env" {
    type = string
}
variable "project" {
    type = string
    default = "Roboshop"
}

variable "common_names" {
    default = {
        Terraform = "True"
        Project =  "Roboshop"
    }
  
}