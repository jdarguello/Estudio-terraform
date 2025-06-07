locals {
  commonTags = {
    CreadoPor = "Terraform"
  }
}

resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.commonTags, {
    Name = "tf vpc"
  })
}

resource "aws_subnet" "tf_public_subnet" {
  depends_on = [aws_vpc.tf_vpc]
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.commonTags, {
    Name : "tf public"
  })
}

resource "aws_subnet" "tf_private_subnet" {
  depends_on = [aws_vpc.tf_vpc]
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = merge(local.commonTags, {
    Name = "tf private"
  })
}

resource "aws_internet_gateway" "tf_igw" {
  depends_on = [aws_vpc.tf_vpc]
  vpc_id     = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf IGW"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "tf rt"
  }
}

resource "aws_route_table_association" "tf_igw_ass" {
  route_table_id = aws_route_table.tf_public_rt.id
  subnet_id      = aws_subnet.tf_public_subnet.id
}