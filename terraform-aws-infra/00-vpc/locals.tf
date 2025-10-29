locals {
  common_name = "/${var.project}/${var.environment}/vpc_id" #/roboshop/dev/vpc_id
  public_subnet =  "/${var.project}/${var.environment}/public_subnet_id"
  private_subnet =  "/${var.project}/${var.environment}/private_subnet_id"
  database_subnet =  "/${var.project}/${var.environment}/database_subnet_id"
}