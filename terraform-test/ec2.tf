module "catalogue" {
    source = "../terraform-modules"
    ami_id = var.ami_id
    instance_type = var.instance_type
    sg_id = var.sg_id
    tags = var.tags
  
}
output "pub" {
    value = module.catalogue.public_ip
}
output "priv" {
    value = module.catalogue.private_ip
}