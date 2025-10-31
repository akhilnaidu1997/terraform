resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.bastion ]
  subnet_id = local.public_subnet_ids
  user_data = file("bastion.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    delete_on_termination = true
    encrypted = false
  }

  tags = merge(
    var.bastion_tags,
    local.common_tags,{
        Name = "bastion" # roboshop-dev 
    }
  )
}

resource "terraform_data" "terraform" {
  triggers_replace = [
    aws_instance.bastion.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.bastion.public_ip
  }

  provisioner "file" {
    source = "bastion.sh"
    destination = "/tmp/bastion.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod +x /tmp/bastion.sh",
      "sudo sh /tmp/bastion.sh"
     ]
  }
}

# 1️⃣ Create IAM Role
resource "aws_iam_role" "bastion_role" {
  name = "bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 2️⃣ Attach AdministratorAccess Policy
resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3️⃣ Create IAM Instance Profile (needed to attach role to EC2)
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "terraform-admin-profile"
  role = aws_iam_role.bastion_role.name
}
