resource "aws_vpc" "quakewatch_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "quakewatch-vpc" }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.quakewatch_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "quakewatch-public" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.quakewatch_vpc.id
  tags = { Name = "quakewatch-igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.quakewatch_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "quakewatch-public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
