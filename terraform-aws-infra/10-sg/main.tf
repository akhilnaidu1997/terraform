module "sg" {
    count = length(var.sg_name)
    source = "git::https://github.com/akhilnaidu1997/terraform-aws-sg.git"
    project = var.project
    environment = var.environment
    sg_name = var.sg_name[count.index]
    sg_desc = var.sg_desc
    vpc_id = local.vpc_id 

  
}

# resource "aws_security_group_rule" "frontend" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   security_group_id = module.sg[9].sgids
#   source_security_group_id = module.sg[11].sgids
# }