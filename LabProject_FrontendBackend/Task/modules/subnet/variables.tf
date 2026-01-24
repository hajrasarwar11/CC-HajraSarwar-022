variable "my_ip" {
	description = "Your public IP for SSH access"
	type        = string
}
variable "vpc_cidr_block" {
	description = "CIDR block for the VPC"
	type        = string
}

variable "subnet_cidr_block" {
	description = "CIDR block for the public subnet"
	type        = string
}

variable "availability_zone" {
	description = "AWS Availability Zone to use"
	type        = string
}

variable "env_prefix" {
	description = "Environment prefix for resource naming"
	type        = string
}
