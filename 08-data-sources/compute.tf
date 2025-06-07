resource "aws_instance" "tf_ec2" {
  ami                         = data.aws_ami.ubuntu_22.image_id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.eks_public_subnet_1.id

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "tf_ec2"
  }

  lifecycle {
    create_before_destroy = true
  }
}