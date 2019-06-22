provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "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"
}
#########################
# OUTPUT VAR
#########################
output "igw" {
 	value = "${aws_internet_gateway.gw.id}"
}
output "vpc" {
 	value = "${aws_vpc.default.id}"
}

######################################################################
# VPC:
# 	1 x pub
# 	1 x pri
# 	1 x IGW
# 	1 x SG groups
######################################################################

resource "aws_vpc" "default" {
	cidr_block = "10.10.0.0/16"
	enable_dns_hostnames = true

tags = {
	Name = "VPC-Servicios"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}
}
#########################
# Define the public subnet
#########################
resource "aws_subnet" "public-subnet" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "10.10.1.0/24"
	availability_zone = "us-east-1a"

tags = {
	Name = "10.10.1.0/24-PUB-Servicios"
	}
}
#########################
# Define the private subnet
#########################
resource "aws_subnet" "private-subnet" {
	vpc_id = "${aws_vpc.default.id}"
	cidr_block = "10.10.2.0/24"
	availability_zone = "us-east-1f"

tags = {
	Name = "10.10.2.0/24-PUB-Servicios"
	}
}
#########################
# Define the internet gateway
#########################
resource "aws_internet_gateway" "gw" {
	vpc_id = "${aws_vpc.default.id}"
tags= {
    Name = "IGW"
  }
}
#########################
# Define the route table
#########################
resource "aws_route_table" "web-public-rt" {
	  vpc_id = "${aws_vpc.default.id}"

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
}

tags= {
	Name = "Public Subnet RT"
	}
}

#########################
# Assign the route table to the public Subnet
#########################
resource "aws_route_table_association" "web-public-rt" {
	subnet_id = "${aws_subnet.public-subnet.id}"
	route_table_id = "${aws_route_table.web-public-rt.id}"
}
#########################
# Define the security group for public subnet
#########################
resource "aws_security_group" "ssh" {
	name = "SG-SSH"
	description = "Allow incoming SSH access"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.default.id}"

  tags {
    Name = "VPC-SERVICIOS-SG-SSH"
  }
}

