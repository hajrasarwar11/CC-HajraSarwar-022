# Security Group for Web Servers
resource "aws_security_group" "web" {
	name        = "web-sg"
	description = "Allow HTTP from LB SG only; SSH from admin only"
	vpc_id      = var.vpc_id

	       ingress {
		       description = "HTTP from anywhere"
		       from_port   = 80
		       to_port     = 80
		       protocol    = "tcp"
		       cidr_blocks = ["0.0.0.0/0"]
	       }
	ingress {
		description = "SSH from admin"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = [var.admin_cidr]
	}
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name        = "web-sg"
		Role        = "web"
		Environment = var.environment
		Project     = var.project
	}
}

# Web EC2 Instances (2+)
resource "aws_instance" "web" {
		count         = var.instance_count
		ami           = var.ami_id
		instance_type = var.instance_type
		subnet_id     = var.public_subnet_ids[count.index]
		vpc_security_group_ids = [aws_security_group.web.id]
		associate_public_ip_address = true
		key_name      = var.key_name
		tags = {
			Name        = "web-${count.index + 1}"
			Role        = "web"
			Environment = var.environment
			Project     = var.project
		}
}
