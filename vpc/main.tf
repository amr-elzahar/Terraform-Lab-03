resource "aws_vpc" "Demo" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    "Name" = var.tag
  }
}