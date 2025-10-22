variable "ami_id" {
    type = string
}
variable "instance_type" {
    type = string
    validation {
      condition = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
      error_message = "please choose one of these t2.micro, t2.small, t2.medium"
    }
}
variable "sg_id" {
    type = list 
}
variable "tags" {
    type = map 
}
