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
    access_key = "AKIA3QISMVTKCOJAJH4R"
    secret_key = "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"
    region  = "us-east-1"
}

resource "aws_key_pair" "devops_kp" {
    key_name = "devops-key"
    public_key = file("~/.ssh/id_rsa.pub")

    tags = {
        Name = "Devops-Key-Pair"
    }
}

resource "aws_security_group" "devops_sg" {
  name = "devops-sec-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["78.25.4.218/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["78.25.4.218/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Devops-Security-Group"
  }
}

resource "aws_instance" "devops_instance" {
    ami = "ami-06878d265978313ca"
    instance_type = "t2.micro"
    key_name = "devops-key"
    vpc_security_group_ids = [ aws_security_group.devops_sg.id ]

    tags = {
        Name = "Devops-Instance"
    }    

    user_data = file("./user_data.sh")
}
