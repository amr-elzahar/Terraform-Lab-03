variable "type" {
   type = string
   description = "Instance type"
}

variable "vpc_id" {
   type = string
   description = "VPC ID"
}

variable "subnet_id" {
   type = string
   description = "Private subnet ID"
}

variable "private_sg" {
  type = string
  description = "Private security group"
}