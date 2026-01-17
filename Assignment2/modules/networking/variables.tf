variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Subnet CIDR block"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix"
}
