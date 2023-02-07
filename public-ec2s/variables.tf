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
   description = "Public subnet ID"
}

variable "public_sg" {
  type = string
  description = "Public security group"
}