terraform {
  required_version = ">=0.12.28"
  required_providers {
    aws = "~> 2.69"
  }
}

provider "aws" {
  version    = "~> 2.69"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  count         = var.instance_count
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.ec2sg.id
  ]
  tags = var.instance_tags
}

resource "aws_security_group" "ec2sg" {
  name                   = "ssh-ec2-sg"
  revoke_rules_on_delete = true
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.sg_tags
}
