resource "aws_subnet" "subnets" {
  cidr_block        = var.cidr_block
  vpc_id            = var.vpc_id
  availability_zone = var.az

  tags = {
    "Name" = var.tag
  }
}