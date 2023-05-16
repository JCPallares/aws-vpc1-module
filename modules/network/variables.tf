variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_azs" {
  type        = list(string)
  description = "A list of availability zones in the region"
  default     = []
}

variable "vpc_cidr" {
  type = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "vpc_private_subnet" {
  type = list(string)
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "vpc_public_subnet" {
    type = list(string)
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "eip_alloc_id" {
  type    = string
  default = ""
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "dns_support" {
  type    = bool
  default = true
}

variable "dns_hostnames" {
  type    = bool
  default = true
}
