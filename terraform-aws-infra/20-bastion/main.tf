resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.bastion ]
  subnet_id = local.public_subnet_ids

  tags = merge(
    var.bastion_tags,
    local.common_tags,{
        Name = "bastion" # roboshop-dev 
    }
  )
}

