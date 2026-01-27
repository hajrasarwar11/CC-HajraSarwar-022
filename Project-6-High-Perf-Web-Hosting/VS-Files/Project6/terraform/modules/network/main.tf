<<<<<<< HEAD
# modules/network/main.tf

	enable_dns_support   = true
	enable_dns_hostnames = true
	tags = {
		Name = "project6-vpc"
	}
}

# Public Subnets
resource "aws_subnet" "public" {
	count                   = length(var.public_subnet_cidrs)
	vpc_id                  = aws_vpc.main.id
	cidr_block              = var.public_subnet_cidrs[count.index]
	availability_zone       = var.azs[count.index]
	map_public_ip_on_launch = true
	tags = {
		Name = "project6-public-${count.index + 1}"
		Tier = "public"
	}
}

# Private Subnets
resource "aws_subnet" "private" {
	count             = length(var.private_subnet_cidrs)
	vpc_id            = aws_vpc.main.id
	cidr_block        = var.private_subnet_cidrs[count.index]
	availability_zone = var.azs[count.index]
	tags = {
		Name = "project6-private-${count.index + 1}"
		Tier = "private"
	}
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
<<<<<<< HEAD
  vpc_id = aws_vpc.main.id

		Name = "project6-igw"
	}
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
}

# Public Route Table
resource "aws_route_table" "public" {
<<<<<<< HEAD
  vpc_id = aws_vpc.main.id
	tags = {
		Name = "project6-public-rt"
	}
}

resource "aws_route" "public_internet_access" {
	route_table_id         = aws_route_table.public.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
	count          = length(var.public_subnet_cidrs)
	subnet_id      = aws_subnet.public[count.index].id
	route_table_id = aws_route_table.public.id
}

# NAT Gateway (optional, for private subnet egress)
resource "aws_eip" "nat" {
	count = 1
}

resource "aws_nat_gateway" "nat" {
	allocation_id = aws_eip.nat[0].id
	subnet_id     = aws_subnet.public[0].id
	tags = {
		Name = "project6-nat"
	}
	depends_on = [aws_internet_gateway.igw]
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
}

# Private Route Table
resource "aws_route_table" "private" {
<<<<<<< HEAD
	vpc_id = aws_vpc.main.id
	tags = {
		Name = "project6-private-rt"
	}
}

resource "aws_route" "private_nat_gateway" {
	route_table_id         = aws_route_table.private.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private" {
	count          = length(var.private_subnet_cidrs)
	subnet_id      = aws_subnet.private[count.index].id
	route_table_id = aws_route_table.private.id
}
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
