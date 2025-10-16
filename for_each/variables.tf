variable "instance" {
    default = ["mongodb","redis"]
    # default = {
    #     mongodb = "t2.micro"
    #     redis = "t2.micro"
    #     mysql = "t2.micro"
    #     rabbitmq = "t2.micro"
    # }
}
variable "zone_id" {
    default = "Z06190873R7XMZC2PKDSV"
}
variable "domain" {
    default = "daws86s-akhil.shop"
}