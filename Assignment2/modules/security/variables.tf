variable "vpc_id" {
  description = "VPC ID where SGs will be created"
  type        = string
}

variable "env_prefix" {
  description = "Environment prefix for naming"
  type        = string
}

variable "my_ip" {
  description = "Your public IP with /32"
  type        = string
}