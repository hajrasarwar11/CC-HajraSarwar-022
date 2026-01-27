variable "public_subnet_ids" {
	description = "List of public subnet IDs for LB EC2s"
	type        = list(string)
}

variable "ami_id" {
	description = "AMI ID for the EC2 instances"
	type        = string
}

variable "instance_type" {
	description = "EC2 instance type for LBs"
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

variable "vpc_id" {
  description = "The VPC ID for the load balancer security group."
  type        = string
}

variable "key_name" {
	description = "The name of the SSH key pair to use for LB EC2 instances."
	type        = string
}
