# AWS VPC for pritunl
resource "aws_vpc" "pritunl" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.name}-vpc"
    Environment = var.environment
  }
}

# Subnets
resource "aws_subnet" "public_subnet_1a" {
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.public_subnet_1a
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-public-subnet-1a"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "public_subnet_1b" {
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.public_subnet_1b
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-public-subnet-1b"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "public_subnet_1c" {
  availability_zone       = "${var.aws_region}c"
  cidr_block              = var.public_subnet_1c
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-public-subnet-1c"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "public_subnet_1d" {
  availability_zone       = "${var.aws_region}d"
  cidr_block              = var.public_subnet_1d
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-public-subnet-1d"
    "Environment" = var.environment
  }
}

##################
resource "aws_subnet" "private_subnet_1a" {
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.private_subnet_1a
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-private-subnet-1a"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "private_subnet_1b" {
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.private_subnet_1b
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-private-subnet-1b"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "private_subnet_1c" {
  availability_zone       = "${var.aws_region}c"
  cidr_block              = var.private_subnet_1c
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-private-subnet-1c"
    "Environment" = var.environment
  }
}

resource "aws_subnet" "private_subnet_1d" {
  availability_zone       = "${var.aws_region}d"
  cidr_block              = var.private_subnet_1d
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-private-subnet-1d"
    "Environment" = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "pritunl" {
  vpc_id = aws_vpc.pritunl.id
  tags = {
    "Name"        = "${var.name}-igw"
    "Environment" = var.environment
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "pritunl_nat" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.nat_eip.id
}

# Routes and Route Tables
resource "aws_route" "public_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pritunl.id
  route_table_id         = aws_route_table.public_route_table.id
  depends_on             = [aws_route_table.public_route_table]
}

resource "aws_route_table" "public_route_table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pritunl.id
  }
  vpc_id = aws_vpc.pritunl.id
}

resource "aws_route_table" "private_route_table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pritunl_nat.id
  }
  vpc_id = aws_vpc.pritunl.id
}

resource "aws_route_table_association" "public_subnet_1a" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_subnet_1b" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1b.id
}

resource "aws_route_table_association" "public_subnet_1c" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1c.id
}

resource "aws_route_table_association" "public_subnet_1d" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1d.id
}

resource "aws_route_table_association" "private_subnet_1a" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_subnet_1b" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1b.id
}

resource "aws_route_table_association" "private_subnet_1c" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1c.id
}

resource "aws_route_table_association" "private_subnet_1d" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1d.id
}
