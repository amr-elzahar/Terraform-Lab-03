variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "igw_id" {
  type = string
  description = "Interent gateway ID"
}

variable "subnet-1_id" {
  type = string
  description = "Public subnet 1 ID"
}
variable "subnet-2_id" {
  type = string
  description = "Public subnet 2 ID"
}

variable "tag" {
  type = string
  description = "Public route table tag"
}
