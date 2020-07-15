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
  tags          = var.instance_tags
  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2ssh.key_name
  vpc_security_group_ids = [
    aws_security_group.ec2sg.id
  ]
  user_data = templatefile("${path.module}/user_data.tmpl", {})
}

resource "aws_security_group" "ec2sg" {
  name = "ssh-ec2-sg"
  tags = var.sg_tags
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ec2ssh" {
  key_name   = "aws-ec2-ssh"
  public_key = var.aws_ec2_ssh_pubkey
}