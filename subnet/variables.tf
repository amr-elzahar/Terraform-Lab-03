variable "cidr_block" {
  type        = string
  description = "CIDR block for public and private subnets within the Demo VPC"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the Demo VPC"
}

variable "az" {
  type        = string
  description = "AZ for subnets"
}
variable "tag" {
  type        = string
  description = "Subnet tag"
}
