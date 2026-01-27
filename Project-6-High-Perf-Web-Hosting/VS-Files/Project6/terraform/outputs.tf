output "lb_public_ips" {
	description = "Public IPs of LB EC2 instances"
	value       = module.lb_ec2.lb_public_ips
}

output "lb_public_dns" {
	description = "Public DNS names of LB EC2 instances"
	value       = module.lb_ec2.lb_public_dns
}

output "web_private_ips" {
	description = "Private IPs of web EC2 instances"
	value       = module.web_ec2.web_private_ips
}
