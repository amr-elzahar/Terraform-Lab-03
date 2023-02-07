variable "lb-name" {
   type = string
   description = "Wheather it's the public or private one"
}

variable "lb_type" {
  type = string
  description = "Load balancer type"
}
variable "scheme" {
   type = bool
   description = "To determine wheather it's internal or internet-facing"
}

variable "lb_sg_id" {
  type = string
  description = "Load balancer security group ID"
}
variable "subnet-1_id" {
  type = string
  description = "Public subnet 1 ID"
}
variable "subnet-2_id" {
  type = string
  description = "Public subnet 2 ID"
}

variable "tg-name" {
  type = string
  description = "Wheather it's the public or private one"
}

variable "vpc_id" {
   type = string
   description = "VPC ID"
}

variable "ec2-1_id" {
  type = string
  description = "EC2 ID"
}

variable "ec2-2_id" {
  type = string
  description = "EC2 ID"
}