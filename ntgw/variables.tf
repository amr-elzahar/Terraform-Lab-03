variable "subnet_id" {
  type        = string
  description = "Private subnet ID"
}
variable "eip_id" {
  type        = string
  description = "Elastic IP ID"
}

variable "tag" {
  type        = string
  description = "NAT gateway tag"
}