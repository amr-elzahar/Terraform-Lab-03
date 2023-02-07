resource "aws_route_table" "public-route-table" {
  vpc_id = var.vpc_id
  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = var.igw_id
  }

  tags = {
    "Name" = var.tag
  }
}

resource "aws_route_table_association" "public-rtb-association-1" {
  subnet_id      = var.subnet-1_id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-rtb-association-2" {
  subnet_id      = var.subnet-2_id
  route_table_id = aws_route_table.public-route-table.id
}