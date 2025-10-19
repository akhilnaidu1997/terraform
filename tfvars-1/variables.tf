variable "ami" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = "ami id"
}
variable "instance_type" {
    type = string
    description = "instance type for env"
}


variable "env" {
    type = string
  
}
variable "project" {
    default = "roboshop"
}

