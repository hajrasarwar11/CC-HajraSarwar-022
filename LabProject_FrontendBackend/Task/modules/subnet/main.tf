# VPC
resource "aws_vpc" "main" {
	cidr_block = var.vpc_cidr_block
	tags = {
		Name = "${var.env_prefix}-vpc"
	}
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
	vpc_id = aws_vpc.main.id
	tags = {
		Name = "${var.env_prefix}-igw"
	}
}

# Public Subnet
resource "aws_subnet" "public" {
	vpc_id                  = aws_vpc.main.id
	cidr_block              = var.subnet_cidr_block
	availability_zone       = var.availability_zone
	map_public_ip_on_launch = true
	tags = {
		Name = "${var.env_prefix}-public-subnet"
	}
}

# Route Table
resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id
	tags = {
		Name = "${var.env_prefix}-public-rt"
	}
}

# Route to Internet
resource "aws_route" "default_route" {
	route_table_id         = aws_route_table.public.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.gw.id
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public_assoc" {
	subnet_id      = aws_subnet.public.id
	route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "main" {
	name        = "${var.env_prefix}-sg"
	description = "Allow SSH from my IP and HTTP from anywhere"
	vpc_id      = aws_vpc.main.id

	ingress {
		description = "SSH from my IP"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = [var.my_ip]
	}

	ingress {
		description = "HTTP from anywhere"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.env_prefix}-sg"
	}
}
