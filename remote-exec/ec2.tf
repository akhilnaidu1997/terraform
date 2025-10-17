resource "aws_instance" "instance" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.allow-all.id ]

  tags = {
    Name = "Terraform"
    Terraform = "True"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo Instance is getting deleted"
    when = destroy
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
      ]
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop nginx"
      ]
    when = destroy
  }
}

resource "aws_security_group" "allow-all" {
  name   = "allow-all"

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