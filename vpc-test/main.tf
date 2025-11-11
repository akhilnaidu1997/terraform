module "vpc" {
    #source = "../vpc-module"
    source = "git::https://github.com/akhilnaidu1997/terraform.git"
    cidr_block = var.cidr_block
    project = var.project
    environment = var.environment
    vpc_tags = var.vpc_tags
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = true
}

