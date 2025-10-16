variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "sg_name" {
    default = "allow-all"
}
variable "ec2_tags" {
    type = map 
    default = {
        Name = "Terraform"
        Terraform = "True"
  } 
}

variable "egress_from_port" {
    default = 0
}
variable "egress_to_port" {
    default = 0
}
variable "ingress_from_port" {
    default = 0
}
variable "ingress_to_port" {
    default = 0
}
variable "cidr" {
    default = ["0.0.0.0/0"]
}