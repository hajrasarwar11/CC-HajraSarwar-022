variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "VPC CIDR block must be valid."
  }
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.subnet_cidr_block))
    error_message = "Subnet CIDR block must be valid."
  }
}

variable "availability_zone" {
  description = "Availability zone where resources will be deployed"
  type        = string
}

variable "env_prefix" {
  description = "Environment name prefix (e.g. dev, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_key" {
  description = "Path to public SSH key"
  type        = string
}

variable "private_key" {
  description = "Path to private SSH key"
  type        = string
}

variable "backend_servers" {
  description = "Backend server definitions"
  type = list(object({
    name        = string
    script_path = string
  }))
}
