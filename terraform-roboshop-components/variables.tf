variable "instance_type" {
    type = string
}
variable "project" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "component" {
    type = string
}
variable "component_tags" {
    default = {}
}
variable "priority" {
    type = number
}
variable "domain" {
    default = "daws86s-akhil.shop"
}