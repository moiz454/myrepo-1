#AWS region
variable "aws_region" {}

variable "environment" {}

#key pair name
variable "key_name" {}

variable "ssh_user" {}

variable "vpc_net_block" {}

#Instance type
variable "instance_type" {}

variable "appName" {}

#Amazon Linux AMI
variable "ami" {}

variable "PublicSubnetIDs" {
  type = "list"
}

variable "PrivateSubnetIDs" {
  type = "list"
}

variable "InstanceSecGroupID" {}

variable "ELBSecGroupID" {}
