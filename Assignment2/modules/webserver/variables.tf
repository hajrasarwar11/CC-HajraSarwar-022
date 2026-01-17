variable "env_prefix" {
  description = "Environment prefix (e.g. dev, prod)"
  type        = string
}

variable "instance_name" {
  description = "Base name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where instance will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2 instance"
  type        = string
}

variable "public_key" {
  description = "Path to public SSH key"
  type        = string
}

variable "script_path" {
  description = "Path to user-data script"
  type        = string
}

variable "instance_suffix" {
  description = "Unique suffix for instance and key pair"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}
