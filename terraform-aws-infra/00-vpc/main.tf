module "vpc" {
    source = "git::https://github.com/akhilnaidu1997/roboshop-aws-infra.git"
    cidr_block = var.cidr_block
    project = var.project
    environment = var.environment
    vpc_tags = var.common_tags
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
}


