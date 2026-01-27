variable "aws_region" {
	description = "AWS region to deploy resources"
	type        = string
}

variable "vpc_cidr" {
	description = "CIDR block for the VPC"
	type        = string
}

variable "public_subnet_cidrs" {
	description = "List of public subnet CIDRs"
	type        = list(string)
}

variable "private_subnet_cidrs" {
	description = "List of private subnet CIDRs"
	type        = list(string)
}

variable "azs" {
	description = "List of availability zones"
	type        = list(string)
}

variable "ami_id" {
	description = "AMI ID for EC2 instances"
	type        = string
}

variable "instance_type_lb" {
	description = "Instance type for LB EC2s"
	type        = string
	default     = "t3.micro"
}

variable "instance_type_web" {
	description = "Instance type for web EC2s"
	type        = string
	default     = "t3.micro"
}

variable "admin_cidr" {
	description = "Admin IP CIDR allowed for SSH"
	type        = string
}

variable "environment" {
	description = "Deployment environment (test, staging, production)"
	type        = string
}

variable "project" {
	description = "Project name or tag"
	type        = string
}

variable "web_instance_count" {
	description = "Number of web server instances"
	type        = number
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances."
  type        = string
	default     = 2
}
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
