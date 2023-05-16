# Output variable definitions

output "vpc_cidr" {
  value = module.network.vpc.cidr_block
}

output "vpc_public_subnet_cidr" {
  value = module.network.vpc_public_subnets[*].cidr_block
}

output "vpc_private_subnet_cidr" {
  value = module.network.vpc_private_subnets[*].cidr_block
}

output "bastion_public_dns" {
  value = module.bastion.bastion_server.public_dns
}

output "linux_server_private_ip" {
  value = module.linux_server.linux_server.private_ip
}

output "vpc_id" {
  value = module.network.vpc.id
}

output "vpc_private_route_id" {
  value = module.network.vpc_private_route_id
}

/* output "vpc_private_subnets" {
  value = aws_subnet.vpc_private_subnet[*]
} */