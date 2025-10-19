resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = lookup(var.instance_type,terraform.workspace)
  vpc_security_group_ids = [ aws_security_group.allow-all.id ]

  tags = merge(
    local.common_tags,{
        Name = "${local.common_names}-workspaces"
    }
  )
}

resource "aws_security_group" "allow-all" {
  name   = local.common_names 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}