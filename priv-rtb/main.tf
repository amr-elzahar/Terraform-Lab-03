resource "aws_route_table" "private-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.ntgw_id
  }

  tags = {
   "Name" = var.tag
  }
}

resource "aws_route_table_association" "private-rtb-association-1" {
  subnet_id = var.subnet_id
  route_table_id = aws_route_table.private-route-table.id
}

# resource "aws_route_table_association" "private-rtb-association-2" {
#   subnet_id = var.subnet_id-2
#   route_table_id = aws_route_table.private-route-table.id
# }