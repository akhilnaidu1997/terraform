resource "aws_instance" "main" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ local.sg_id ]
  subnet_id = local.private_subnet_ids
  #user_data = file("catalogue.sh")
  #iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  tags = merge(
    local.common_tags,{
        Name = "${local.common_name}-${var.component}" # roboshop-dev 
    }
  )
}

resource "terraform_data" "main" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers_replace = [
        aws_instance.main.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.main.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh ${var.component} ${var.environment}"
    ]
  }
}

resource "aws_ec2_instance_state" "main" {
 instance_id = aws_instance.main.id
 state = "stopped"
 depends_on = [ terraform_data.main ]
}

resource "aws_ami_from_instance" "main" {
  name               = "${var.component}-ami"
  source_instance_id = aws_instance.main.id
  depends_on = [ aws_ec2_instance_state.main ]
}

resource "aws_lb_target_group" "main" {
  name        = "${local.common_name}-${var.component}"
  port        = local.tg_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id

  health_check {
    interval = 10 # Time between health checks (in seconds)
    path = local.health_check_path # Endpoint to check
    port = local.tg_port
    protocol = "HTTP" # Protocol for health checks
    timeout = 5 # Timeout for each health check
    healthy_threshold = 2 # Consecutive successes to mark healthy
    unhealthy_threshold = 2 # Consecutive failures to mark unhealthy
    matcher = "200-299" # HTTP response codes indicating success
  }
}

resource "aws_launch_template" "main" {
  name = "${local.common_name}-${var.component}"
  image_id = aws_ami_from_instance.main.id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.sg_id]
  instance_initiated_shutdown_behavior = "terminate"
  # tags for instance during launch
  update_default_version = true
  tag_specifications {
    resource_type = "instance"

    tags = merge(
    local.common_tags,{
        Name = "${local.common_name}-${var.component}" # roboshop-dev 
    }
  )
  }
  # tags for volumes
  tag_specifications {
    resource_type = "volume"

    tags = merge(
    local.common_tags,{
        Name = "${local.common_name}-${var.component}" # roboshop-dev 
    }
  )
  }
  # tags for launch template
  tags = merge(
    local.common_tags,{
        Name = "${local.common_name}-${var.component}" # roboshop-dev 
    }
  )

}

resource "aws_autoscaling_group" "main" {
  name                      = "${local.common_name}-${var.component}"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  target_group_arns = [aws_lb_target_group.main.arn]
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }      
  vpc_zone_identifier       = local.private_subnet_id
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  dynamic "tag" {
    for_each = merge(
        local.common_tags,{
            Name = "${local.common_name}-${var.component}"
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

resource "aws_autoscaling_policy" "main" {
  name                   = "${local.common_name}-${var.component}"
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = local.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    host_header {
      values = [ local.host_context ]
    }
  }
}

resource "terraform_data" "delete_ec2" {
  triggers_replace = [
    aws_instance.main.id
  ]
  
  provisioner "local-exec" {
    command = " aws ec2 terminate-instances --instance-ids ${aws_instance.main.id} " 
  }

  depends_on = [ aws_autoscaling_policy.main ]
}