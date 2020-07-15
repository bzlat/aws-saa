variable "region" {
  default = "eu-central-1"
  type    = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "ami" {
  default = "ami-00edb93a4d68784e3"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "instance_count" {
  default = 1
  type    = number
}

variable "instance_tags" {
  default = {
    Name  = "aws-saa-instance"
    name  = "aws-saa-instance"
    owner = "bzlat"
  }
  type = map(string)
}

variable "sg_tags" {
  default = {
    name  = "aws-saa-security-group"
    owner = "bzlat"
  }
  type = map(string)
}

variable "aws_ec2_ssh_pubkey" {
  description = "ecdsa ssh public key for connecting to the AWS EC2 instances"
  type        = string
}