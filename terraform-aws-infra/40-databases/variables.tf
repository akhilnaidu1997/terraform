variable "project" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "database_tags" {
    type = map
    default = {}
}