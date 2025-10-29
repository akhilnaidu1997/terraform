terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
  backend "s3" {
    bucket = "daws86s-akhil"
    key    = "remote-state-module-bastion"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}