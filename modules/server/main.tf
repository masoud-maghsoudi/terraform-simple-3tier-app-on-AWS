data "aws_ami" "latest_rhel" {
  filter {
    name   = "name"
    values = ["RHEL-9.2.0_HVM-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners      = ["309956199498"] # Redhat
  most_recent = true
}

resource "aws_instance" "frontend-instance" {
  ami                         = data.aws_ami.latest_rhel.id
  instance_type               = "t2.micro"
  availability_zone           = var.app_availability_zone
  subnet_id                   = var.public-subnet.id
  associate_public_ip_address = true
  key_name                    = var.app-key-pair.key_name
  vpc_security_group_ids      = [aws_security_group.app-frontend-sg.id]
  tags = {
    Name = "app-frontend-server"
  }
}

resource "aws_security_group" "app-frontend-sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "app-frontend-sg"
  }

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 80
    to_port   = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "backend-instance" {
  ami                         = data.aws_ami.latest_rhel.id
  instance_type               = "t2.micro"
  availability_zone           = var.app_availability_zone
  subnet_id                   = var.private-subnet.id
  associate_public_ip_address = false
  key_name                    = var.app-key-pair.key_name
  vpc_security_group_ids      = [aws_security_group.app-backend-sg.id]
  tags = {
    Name = "app-backend-server"
  }
}

resource "aws_security_group" "app-backend-sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "app-backend-sg"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
}
