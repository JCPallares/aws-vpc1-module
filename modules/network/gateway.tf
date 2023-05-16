# Gateway Resources

###########
# Internet Gateway
###########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw_${var.vpc_name}"
  }
}

resource "aws_route_table" "vpc_public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}_public_route"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count = length(aws_subnet.vpc_public_subnet)

  subnet_id      = aws_subnet.vpc_public_subnet[count.index].id
  route_table_id = aws_route_table.vpc_public_route.id
}

######
# NAT
######
resource "aws_eip" "eip" {
  count = (var.eip_alloc_id == "" ? 1 : 0)

  vpc = true

  #lifecycle {
  #  prevent_destroy = true
  #}

  tags = {
    Name = "eip_${var.vpc_name}"
  }
}

#PUBLIC NAT GATEWAY
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.eip_alloc_id != "" ? var.eip_alloc_id : aws_eip.eip[0].id
  subnet_id     = aws_subnet.vpc_public_subnet[0].id

  tags = {
    Name = "nat_gw_${var.vpc_name}"
  }

  depends_on = [aws_eip.eip]
}

resource "aws_route_table" "vpc_private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.vpc_name}_private_route"
  }
}

resource "aws_route_table_association" "private_route_association" {
  count = length(aws_subnet.vpc_private_subnet)

  subnet_id      = aws_subnet.vpc_private_subnet[count.index].id
  route_table_id = aws_route_table.vpc_private_route.id
}
