output "web_instance_ids" {
	description = "IDs of web EC2 instances"
	value       = [for i in aws_instance.web : i.id]
}

output "web_private_ips" {
	description = "Private IPs of web EC2 instances"
	value       = [for i in aws_instance.web : i.private_ip]
}
