variable "ami" {
    default = "ami-09c813fb71547fc4f"
}
variable "instance_type" {
    type = map
    default = {
        dev = "t2.micro"
        prod = "t3.micro"
    }
}
variable "env" {
    type = map 
    default = {
        dev = "dev"
        prod = "prod"
    }
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