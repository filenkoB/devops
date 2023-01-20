terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 0.12"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

data "aws_iam_policy_document" "s3_user_pol_doc" {
  statement {
    effect = "Allow"
    actions = [ "s3:*" ]
    resources = [ "*" ]
  }
}

data "aws_iam_policy_document" "s3_bucket_pol_data" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }
    effect = "Allow"
    actions = [ "s3:GetObject" ]
    resources = [ "arn:aws:s3:::filenko-devops-s3/*" ]
  }
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region  = "us-east-1"
}

resource "aws_key_pair" "devops_kp" {
    key_name = "devops-key"
    public_key = file(var.ssh_key_path)

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
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_s3_bucket" "filenko-devops-s3" {
    bucket = "filenko-devops-s3"
    acl = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket_pol" {
    bucket = aws_s3_bucket.filenko-devops-s3.id
    policy = data.aws_iam_policy_document.s3_bucket_pol_data.json
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_config" {
    bucket = aws_s3_bucket.filenko-devops-s3.id
    index_document {
      suffix = "index.html"
    }
}

resource "aws_iam_user" "s3_user" {
    name = "s3_user"

    tags = {
        Name = "S3-User"
    }
}

resource "aws_iam_user_policy" "s3_user_pol" {
    name = "s3_user_pol"
    user = aws_iam_user.s3_user.name

    policy = "${data.aws_iam_policy_document.s3_user_pol_doc.json}"
}