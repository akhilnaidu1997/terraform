module "vpc" {
    source = "../vpc-module"
    cidr_block = var.cidr_block
    project = var.project
    environment = var.environment
    vpc_tags = var.vpc_tags
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
}

