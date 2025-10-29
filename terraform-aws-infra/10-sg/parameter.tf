resource "aws_ssm_parameter" "sg_ids" {
  count = length(var.sg_name)
  name  = "/${var.project}/${var.environment}/${var.sg_name[count.index]}_sg_id"
  type  = "String"
  value = module.sg[count.index].sgids
}