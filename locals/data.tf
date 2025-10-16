data "aws_ami" "data_source" {
  most_recent = true
  owners      = ["973714476881"]
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# output "instance" {
#     value = data.aws_ami.data_source.id
  
# }

# data "aws_instance" "inst" {
#   instance_id = "i-09553162541b15fb8"

#   filter {
#     name   = "image-id"
#     values = ["ami-09c813fb71547fc4f"]
#   }

#   filter {
#     name   = "tag:Name"
#     values = ["mongodb"]
#   }
# }

# output "newinst" {
#     value = data.aws_instance.inst.private_ip
  
# }