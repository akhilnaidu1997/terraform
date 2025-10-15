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

variable "instance" {
    default = ["mongodb","redis"]
  
}

variable "zone_id" {
    default = "Z06190873R7XMZC2PKDSV"
}
variable "domain_name" {
    default = "daws86s-akhil.shop"
}