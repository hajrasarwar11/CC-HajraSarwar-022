# Security Group for LBs
resource "aws_security_group" "lb" {
	name        = "lb-sg"
	description = "Allow HTTP, HTTPS from anywhere; SSH from admin only"
	vpc_id      = var.vpc_id

	ingress {
		description = "HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		description = "HTTPS"
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		description = "SSH"
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
		Name        = "lb-sg"
		Role        = "lb"
		Environment = var.environment
		Project     = var.project
	}
}

# LB EC2 Instances (2, one per subnet/AZ)
resource "aws_instance" "lb" {
       count         = 2
       ami           = var.ami_id
       instance_type = var.instance_type
       subnet_id     = var.public_subnet_ids[count.index]
       vpc_security_group_ids = [aws_security_group.lb.id]
       associate_public_ip_address = true
       key_name      = var.key_name
       tags = {
	       Name        = "lb-${count.index + 1}"
	       Role        = "lb"
	       Environment = var.environment
	       Project     = var.project
       }
}
