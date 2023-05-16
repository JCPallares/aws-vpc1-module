terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region

  # This specifies the basic owner tags to resources created by this project
/*   default_tags {
    tags = {
      Owner = "Juan Cruz Pallares Valenzuela"
    }
  } */
}

module "network" {
  source = "./modules/network"

  vpc_name           = var.vpc_name
  vpc_azs            = var.vpc_azs
  vpc_cidr           = var.vpc_cidr
  vpc_private_subnet = var.vpc_private_subnet
  vpc_public_subnet  = var.vpc_public_subnet
}

module "security_group" {
  source = "./modules/security_group"
  vpc_name = var.vpc_name
  vpc_id   = module.network.vpc.id
}

#KEY GENERATOR
resource "tls_private_key" "generated-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#STORE THE KEY
resource "local_file" "store_key" { 
  filename = "./.ssh/key.pem"
  content = tls_private_key.generated-key.private_key_pem
}

#USE THE KEY
resource "aws_key_pair" "key_pair_vpc1" {
  key_name   = "key_pair_vpc1"
  public_key = tls_private_key.generated-key.public_key_openssh
}

module "bastion" {
  source = "./modules/bastion"

  security_group_id = module.security_group.sg_public_id
  subnet_id         = module.network.vpc_public_subnets[0].id
  ssh_key_name      = aws_key_pair.key_pair_vpc1.key_name

}

module "linux_server" {
  source = "./modules/linux_server"

  security_group_id = module.security_group.sg_private_id
  subnet_id         = module.network.vpc_private_subnets[0].id
  ssh_key_name      = aws_key_pair.key_pair_vpc1.key_name

  # Used just to add dependency for Internet connection, before create ec2 instance
  vpc_igw_id = module.network.vpc_igw_id
}