# Output variable definitions

output "vpc" {
  value = aws_vpc.vpc
}

output "vpc_public_subnets" {
  value = aws_subnet.vpc_public_subnet[*]
}

output "vpc_private_subnets" {
  value = aws_subnet.vpc_private_subnet[*]
}

output "vpc_public_route_id" {
  value = aws_route_table.vpc_public_route.id
}

output "vpc_private_route_id" {
  value = aws_route_table.vpc_private_route.id
}

output "vpc_igw_id" {
  value = aws_nat_gateway.nat_gw.id
}
