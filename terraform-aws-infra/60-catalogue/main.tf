resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.catalogue_sg_id ]
  subnet_id = local.private_subnet_ids
  user_data = file("catalogue.sh")
  #iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  tags = merge(
    var.catalogue_tags,
    local.common_tags,{
        Name = "catalogue" # roboshop-dev 
    }
  )
}

resource "terraform_data" "catalogue" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.catalogue.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue dev"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
 instance_id = aws_instance.catalogue.id
 state = "stopped"
 depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
}