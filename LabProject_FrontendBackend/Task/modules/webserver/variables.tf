
variable "ami" {
	description = "AMI ID for EC2 instance(s)"
	type        = string
}

variable "instance_type" {
	description = "EC2 instance type"
	type        = string
}

variable "subnet_id" {
	description = "Subnet ID to launch instance(s) in"
	type        = string
}

variable "security_group_id" {
	description = "Security group ID to attach"
	type        = string
}

variable "key_name" {
	description = "SSH key pair name"
	type        = string
}

variable "instance_count" {
	description = "Number of instances to launch (for backends)"
	type        = number
	default     = 1
}

variable "tags" {
	description = "Tags to apply to instance(s)"
	type        = map(string)
	default     = {}
}
