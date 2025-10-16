locals {
  instance_type = "t2.micro"
  common_name = "${var.project}-${var.env}"
  ami = "${data.aws_ami.data_source.id}"
  tags = merge(
    var.ec2_tags,
    {
      Name = "${local.common_name}-locals-demo"
    }
  )
}