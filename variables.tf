variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "root_volume_size" {
  default = 8
}

variable "app_volume_size" {
  default = 10
}

variable "sg_ingress_port" {
  default = 22
}

variable "sg_ingress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
