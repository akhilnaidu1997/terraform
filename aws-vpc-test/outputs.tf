output "vpc_out" {
    value = module.vpc.vpc_out
}
output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
    value = module.vpc.private_subnet_ids
}
output "database_subnet_ids" {
    value = module.vpc.database_subnet_ids
}