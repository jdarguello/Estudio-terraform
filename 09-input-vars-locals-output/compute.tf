locals {
  common_tags = {
    Name = "tf_ec2"
  }
}

resource "aws_instance" "tf_ec2" {
  ami           = data.aws_ami.ubuntu_20.id
  instance_type = var.ec2_type

  tags = local.common_tags

  root_block_device {
    volume_size = var.ec2_volume_config.size
    volume_type = var.ec2_volume_config.type
  }

  lifecycle {
    create_before_destroy = true
  }
}