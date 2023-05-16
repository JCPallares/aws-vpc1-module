# Input variable definitions

variable "aws_region" {
  type        = string
  description = "Set here the region where to deploy your resource"
}

variable "vpc_name" {
  type    = string
  default = "vpc_staging"
}

variable "vpc_azs" {
  type        = list(string)
  description = "List of Availability Zones"
  default     = []
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
}

variable "vpc_private_subnet" {
  type        = list(any)
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "vpc_public_subnet" {
  type        = list(any)
  description = "A list of public subnets inside the VPC"
  default     = []
}