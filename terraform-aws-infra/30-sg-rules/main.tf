resource "aws_security_group_rule" "backend_alb_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = local.backend_alb_id
  source_security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "bastion_sg_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.bastion_sg_id
  cidr_blocks =  ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongodb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "redis" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "rabbitmq" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.rabbitmq_sg_id
  source_security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "mysql" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "mongodb-1" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.bastion_sg_id
}