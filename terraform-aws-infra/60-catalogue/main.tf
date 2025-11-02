resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ local.catalogue_sg_id ]
  subnet_id = local.private_subnet_ids
  #user_data = file("catalogue.sh")
  #iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  tags = merge(
    var.catalogue_tags,
    local.common_tags,{
        Name = "${local.common_name}-catalogue" # roboshop-dev 
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

resource "aws_lb_target_group" "catalogue" {
  name        = "${local.common_name}-catalogue"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = local.vpc_id

  health_check {
    interval = 10 # Time between health checks (in seconds)
    path = "/health" # Endpoint to check
    protocol = "HTTP" # Protocol for health checks
    timeout = 5 # Timeout for each health check
    healthy_threshold = 2 # Consecutive successes to mark healthy
    unhealthy_threshold = 2 # Consecutive failures to mark unhealthy
    matcher = "200-299" # HTTP response codes indicating success
  }
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  instance_initiated_shutdown_behavior = "terminate"
  # tags for instance during launch
  tag_specifications {
    resource_type = "instance"

    tags = merge(
    var.catalogue_tags,
    local.common_tags,{
        Name = "${local.common_name}-catalogue" # roboshop-dev 
    }
  )
  }
  # tags for volumes
  tag_specifications {
    resource_type = "volume"

    tags = merge(
    var.catalogue_tags,
    local.common_tags,{
        Name = "${local.common_name}-catalogue" # roboshop-dev 
    }
  )
  }
  # tags for launch template
  tags = merge(
    var.catalogue_tags,
    local.common_tags,{
        Name = "${local.common_name}-catalogue" # roboshop-dev 
    }
  )

}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name}-catalogue"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  target_group_arns = [aws_lb_target_group.catalogue.arn]
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }      
  vpc_zone_identifier       = local.private_subnet_id

  dynamic "tag" {
    for_each = merge(
        local.common_tags,{
            Name = local.common_name
        }
    )
    content {
        key                 = tag.key
        value               = tag.value
        propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${local.common_name}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}

