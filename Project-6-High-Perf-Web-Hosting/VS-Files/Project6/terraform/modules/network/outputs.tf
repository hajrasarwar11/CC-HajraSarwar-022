	description = "VPC ID"
	value       = aws_vpc.main.id
}

output "public_subnet_ids" {
	description = "List of public subnet IDs"
	value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
	description = "List of private subnet IDs"
	value       = [for s in aws_subnet.private : s.id]
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
}
