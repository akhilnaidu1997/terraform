variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "sg_id" {
    default = ["sg-0d9724b44c97a6c47"]
}
variable "tags" {
    default = {
        Name = "Terraform"
        Terraform = "True"
    }
}