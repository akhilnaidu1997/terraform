variable "project" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}
variable "sg_name" {
    default = [
        # databases
        "mongodb","redis","rabbitmq","mysql",
        # backend
        "catalogue","user","cart","shipping","payment",
        # frontend
        "frontend",
        # bastion sg
        "bastion",
        # frontend-alb
        "frontend-alb",
        # backend-alb
        "backend-alb",
        ]
}
variable "sg_desc" {
    default = "create sg for all modules"
}
