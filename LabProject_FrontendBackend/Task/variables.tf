# VPC and Subnet Variables
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

variable "instance_type" {
	description = "EC2 instance type"
	type        = string
}

variable "public_key" {
	description = "SSH public key for EC2 key pair"
	type        = string
}

variable "private_key" {
	description = "SSH private key for Ansible access (not used in Terraform)"
	type        = string
	sensitive   = true
}
