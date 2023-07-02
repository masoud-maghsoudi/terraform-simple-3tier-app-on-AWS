resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.app_availability_zone

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table" "app-private-rtb" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "private-subnet-rtb-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.app-private-rtb.id
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.app_availability_zone

  tags = {
    Name = "public-subnet-${var.app_availability_zone}"
  }
}

resource "aws_internet_gateway" "app-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "app-igw"
  }
}

resource "aws_route_table" "app-public-rtb" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-igw.id
  }

}

resource "aws_route_table_association" "public-subnet-rtb-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.app-public-rtb.id
}
