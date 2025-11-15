resource "aws_ssm_parameter" "listener_arn" {
  name  = "/${var.project}/${var.environment}/listener_arn_frontend"
  type  = "String"
  value = aws_lb_listener.front_end.arn
}