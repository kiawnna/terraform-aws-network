// Naming/global variables
variable "environment" {
  type = string
}

// Cidr blocks
variable "vpc_cidr_block" {
    type = string
    default = "10.200.0.0/16"
}
variable "public_subnet1_cidr_block" {
    type = string
    default = "10.200.0.0/24"
}
variable "public_subnet2_cidr_block" {
    type = string
    default = "10.200.1.0/24"
}
variable "private_subnet1_cidr_block" {
    type = string
    default = "10.200.3.0/24"
}
variable "private_subnet2_cidr_block" {
    type = string
    default = "10.200.4.0/24"
}

// Availability Zones
variable "first_az" {
  type = string
  default = data.aws_availability_zones.available.names[0]
}
variable "second_az" {
  type = string
  default = data.aws_availability_zones.available.names[1]
}