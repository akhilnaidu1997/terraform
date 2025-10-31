resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.mongodb_sg_id ]
  subnet_id = local.database_subnet_ids

  tags = merge(
    var.database_tags,
    local.common_tags,{
        Name = "mongodb" # roboshop-dev 
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
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}

resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.redis_sg_id ]
  subnet_id = local.database_subnet_ids

  tags = merge(
    var.database_tags,
    local.common_tags,{
        Name = "redis" # roboshop-dev 
    }
  )
}

resource "terraform_data" "redis" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.redis.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.rabbitmq_sg_id ]
  subnet_id = local.database_subnet_ids

  tags = merge(
    var.database_tags,
    local.common_tags,{
        Name = "rabbitmq" # roboshop-dev 
    }
  )
}

resource "terraform_data" "rabbitmq" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.rabbitmq.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}

resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.mysql_sg_id ]
  subnet_id = local.database_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name


  tags = merge(
    var.database_tags,
    local.common_tags,{
        Name = "mysql" # roboshop-dev 
    }
  )
}

resource "terraform_data" "mysql" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.mysql.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }
}


# 1️⃣ Create IAM Role for EC2
resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-parameter-role"

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

# 2️⃣ Create IAM Policy for SSM Parameter Access
resource "aws_iam_policy" "ssm_parameter_policy" {
  name        = "ssm-parameter-access"
  description = "Allows fetching SSM Parameter Store values"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSSMParameterRead"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
        ]
        Resource = "arn:aws:ssm:*:*:parameter/*"
      }
    ]
  })
}

# 3️⃣ Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_parameter_policy.arn
}

# 4️⃣ Create an Instance Profile to attach to EC2
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_route53_record" "mongodb" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name    = "mongodb-${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true 
}