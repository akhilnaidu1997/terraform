module "catalogue" {
    source = "../aws-instance-module"
    ami_id = var.ami_id
    instance_type = var.instance_type
    sg_id = var.sg_id
    tags = var.tags
}

output "pub_ip" {
    value = module.catalogue.public_ip
}

output "priv_ip" {
    value = module.catalogue.private_ip
}