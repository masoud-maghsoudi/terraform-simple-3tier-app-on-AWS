resource "aws_vpc" "app-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "app-vpc"
  }
}

resource "aws_key_pair" "app-key-pair" {
  key_name   = "app-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM08R+1Flyr6XvNg6gG3QbJox1zy6CZJYeoapOSLQ69X3uy8pS+GAXwNdRKr2M/uHAms9Cg/qVWFM7amFEwBVAny0ia4GUL9A4Jb4DqNqwDtWFZSPFQJ1Fi0s6PoOdkioEtw30yhX5rB49rwMd431huzKzfaTw+BXeE8D0CqAjQtUzxBWLT0kZ8nNkdMuy9vlCZ+5j9TwBSTm4oCdooLNqDXl6glUEBMYf+UjO9HRaK83fzw6Lg4SpNYMKS8iaO+N65nOO6oQtC0ytXxS1ecCpgoza3DNU1Srf6gY7/mWlXOBgJ//QnqjUJgI6+TdGVg5hP1RjV4vS53FdwbTwNFAAo8pPa6MK/FxY8njToFfCAAOCmnx6zdWnQiY/M8Icdp39qeBlw/ZG6To91ef2SoTYXjj8SL4SqUgAu/ktVY0Uzg4r+y8vngv6PvSt9/XGSuSSXMNLSd0HDnFkUhjdYU6EUooYOimMnpvfRN6792fq1iLU/BBtahxN6NxVDwxQtKs= masoud@Masoud-HP-BLUE"
}

module "app-subnet" {
  source                    = "./modules/subnet"
  vpc_id                    = aws_vpc.app-vpc.id
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  app_availability_zone     = var.app_availability_zone
}

module "app-server" {
  source                = "./modules/server"
  vpc_id                = aws_vpc.app-vpc.id
  app_availability_zone = var.app_availability_zone
  public-subnet         = module.app-subnet.public-subnet
  private-subnet        = module.app-subnet.private-subnet
  vpc_cidr_block        = var.vpc_cidr_block
  app-key-pair          = aws_key_pair.app-key-pair
}

module "app-storage" {
  source = "./modules/storage"
}

module "app-database" {
  source = "./modules/database"
}
