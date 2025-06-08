data "aws_ami" "ubuntu_20" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
}

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.28.0-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }
}