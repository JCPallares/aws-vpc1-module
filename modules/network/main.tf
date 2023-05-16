# VPC Resources

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "vpc_public_subnet" {
  count = length(var.vpc_azs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnet[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = var.vpc_azs[count.index]

  tags = {
    Name = "${var.vpc_name}_public_subnet"
  }
}

resource "aws_subnet" "vpc_private_subnet" {
  count = length(var.vpc_azs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_private_subnet[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = var.vpc_azs[count.index]

  tags = {
    Name = "${var.vpc_name}_private_subnet"
  }
}
/* ESTO ESTA EN GATEWAY.TF
# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "vpc_private_route" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "vpc_private_route_table_association" {
  count = length(aws_subnet.vpc_private_subnet)

  subnet_id      = aws_subnet.vpc_private_subnet[count.index].id
  route_table_id = aws_route_table.vpc_private_route.id
}
 */