variable "project" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "catalogue_tags" {
    type = map
    default = {}
}