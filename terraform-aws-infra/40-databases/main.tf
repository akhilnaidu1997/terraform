resource "aws_instance" "mongodb" {
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

resource "terraform_data" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.mongodb.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh"
    ]
  }
}
