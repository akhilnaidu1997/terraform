resource "aws_security_group" "allow-all" {
  name   = "allow-all"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  dynamic "ingress" {
    for_each = toset(var.ports)
    content {
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "TCP"
        cidr_blocks      = ["0.0.0.0/0"]
    }

  }
}