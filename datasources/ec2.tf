# resource "aws_instance" "instance" {
#   ami           = data.aws_ami.data_source.id
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [ aws_security_group.allow-all.id ]

#   tags = {
#     Name = "Terraform"
#     Terraform = "True"
#   }
# }

# resource "aws_security_group" "allow-all" {
#   name   = "allow-all"

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
# }