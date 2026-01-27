output "lb_public_ips" {
	description = "Public IPs of LB EC2 instances"
	value       = [for i in aws_instance.lb : i.public_ip]
}

output "lb_public_dns" {
	description = "Public DNS names of LB EC2 instances"
	value       = [for i in aws_instance.lb : i.public_dns]
}

output "lb_private_ips" {
	description = "Private IPs of LB EC2 instances"
	value       = [for i in aws_instance.lb : i.private_ip]
}

output "lb_sg_id" {
	description = "Security Group ID for LB EC2 instances"
	value       = aws_security_group.lb.id
}
