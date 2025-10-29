variable "project" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "bastion_tags" {
    type = map
    default = {}
}