variable "vpc_id" {
  type = string
}
variable "app_availability_zone" {
  type    = string
  default = "us-west-2a"
}
variable "app-key-pair" {
  description = "(Required) The name of the key pair to use for SSH access."
}
variable "public-subnet" {
  description = "(Required) subnet that server will be created on."
}
variable "private-subnet" {
  description = "(Required) subnet that server will be created on."
}
variable "vpc_cidr_block" {
  type = string
}

