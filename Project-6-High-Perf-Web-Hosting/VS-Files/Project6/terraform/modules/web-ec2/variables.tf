variable "key_name" {
	description = "The name of the SSH key pair to use for EC2 instances."
	type        = string
}
variable "public_subnet_ids" {
	description = "List of public subnet IDs for web EC2s"
	type        = list(string)
}
variable "private_subnet_ids" {
	description = "List of private subnet IDs for web EC2s"
	type        = list(string)
}

variable "vpc_id" {
	description = "VPC ID for the web EC2 instances"
	type        = string
}

variable "ami_id" {
	description = "AMI ID for the EC2 instances"
	type        = string
}

variable "instance_type" {
	description = "EC2 instance type for web servers"
	type        = string
	default     = "t3.micro"
}

variable "admin_cidr" {
	description = "Admin IP CIDR allowed for SSH"
	type        = string
}

variable "lb_sg_id" {
	description = "Security group ID of the load balancer"
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

variable "instance_count" {
	description = "Number of web server instances"
	type        = number
	default     = 2
}
