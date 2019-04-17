variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "ami" {
  description = "Amazon machine image"
}
variable "vpc_id" {
  description = "VPC where this app will launch"
}
variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}

variable "subnet_2" {
  description = "First Subnet for DC application"
}

variable "subnet_1" {
  description = "Second Subnet for DC application"
}

variable "security_group_2" {
  description = "DC security group"
}

variable "security_group_1" {
  description = "Infosec security group"
}

variable "image_url" {
  description = "Role which Allows EC2 to call AWS services on your behalf."
}