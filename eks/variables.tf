variable "region" {}
variable "project" {}
variable "environment" {}
variable "role" {
  default = "vpc"
}
variable "traffic_type" {
  default = "ALL"
}
variable "cidr" {}
variable "newbits" {
  default = 8
}
variable "azs" {}
variable "private_subnet_count" {
  default = 0
}
variable "public_subnet_count" {
  default = 2
}