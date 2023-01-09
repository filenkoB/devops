terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 0.12"
}

provider "aws" {
    access_key = ".."
    secret_key = ".."
    region  = "us-east-1"
}

resource "aws_instance" "devops_instance" {
    ami = "ami-06878d265978313ca"
    instance_type = "t2.micro"

    tags = {
        Name = "DevopsInstance"
    }
}
