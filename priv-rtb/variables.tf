variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "ntgw_id" {
   type = string
   description = "NAT gagteway ID"
}

variable "subnet_id" {
  type = string
  description = "Private subnet IDs "
}

variable "tag" {
   type = string
   description = "Private route table tag"
}