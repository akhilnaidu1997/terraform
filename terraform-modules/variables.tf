variable "ami_id" {
    type = string
    description = "please provide ami id here"
}
variable "instance_type" {
    type = string
    default = "Please provide instance type here"
    validation {
      condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
      error_message = "Please choose only from t2.micro, t2.small, t2.medim"
    }
}
variable "sg_id" {
    type = list 
}
variable "tags" {
    type = map 
    default = {}
}