resource "aws_vpc" "tf_vpc" {
  cidr_block = "162.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "tf vpc"
  })
}

resource "aws_subnet" "tf_public_subnet" {
  count      = var.count_subnets
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "162.0.${count.index}.0/24"

  tags = merge(local.common_tags, {
    Name = "tf-subnet-${local.common_tags.Project}-${count.index}"
  })
}