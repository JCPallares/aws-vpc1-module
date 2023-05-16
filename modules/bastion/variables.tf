# Input variable definitions

variable "instance_type_ec2" {
  description = "Instance type to deploy"
  type        = string
  default     = "t2.micro"
}

variable "security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_key_name" {
  type = string
}