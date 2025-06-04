terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "tf_vpc_prueba" {
  cidr_block = "192.160.0.0/16"
}

resource "aws_subnet" "tf_private_subnet" {
  vpc_id = aws_vpc.tf_vpc_prueba.id
  cidr_block = "192.160.0.0/24"
}

resource "aws_subnet" "tf_public_subnet" {
  vpc_id = aws_vpc.tf_vpc_prueba.id
  cidr_block = "192.160.1.0/24"
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc_prueba
}

resource "aws_route_table" "tf_rt" {
    vpc_id = aws_vpc.tf_vpc_prueba.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tf_igw.id
    }
}

resource "aws_route_table_association" "tf_public_rt" {
    route_table_id = aws_route_table.tf_rt.id
    subnet_id = aws_subnet.tf_public_subnet.id
}