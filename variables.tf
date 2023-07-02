variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}
variable "vpc_cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}
variable "public_subnet_cidr_block" {
  type    = string
  default = "192.168.1.0/24"
}
variable "private_subnet_cidr_block" {
  type    = string
  default = "192.168.0.0/24"
}
variable "app_availability_zone" {
  type    = string
  default = "us-west-2a"
}
