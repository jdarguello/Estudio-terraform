locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu_20.id
    nginx  = data.aws_ami.nginx.id
  }
}

resource "aws_instance" "tf_instance_count" {
  count         = var.ec2_count
  ami           = data.aws_ami.ubuntu_20.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.tf_public_subnet[var.ec2_count].id

  tags = merge(local.ec2_tags, {
    Name = "${local.ec2_tags.Project}-${count.index}"
  })
}

resource "aws_instance" "tf_instance_list" {
  count         = length(var.ec2_list)
  ami           = local.ami_ids[var.ec2_list[count.index].ami]
  instance_type = var.ec2_list[count.index].type

  subnet_id = aws_subnet.tf_public_subnet[var.ec2_count].id
  tags      = merge(local.ec2_tags, {
    Name = "${local.ec2_tags.Project}-${count.index}-${var.ec2_list[count.index].ami}"
  })
}

resource "aws_instance" "tf_instance_map" {
  for_each = var.ec2_map
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.type

  subnet_id = aws_subnet.tf_public_subnet[each.value.subnet_index].id
  tags      = merge(local.ec2_tags, {
    Name = "${local.ec2_tags.Project}-${each.key}"
  })
}