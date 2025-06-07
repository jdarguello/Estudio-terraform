locals {
  commons = {
    Name = "tf web page"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-010e099e651d8635e"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.tf_public_subnet.id
  vpc_security_group_ids = [aws_security_group.tf_sg.id]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  tags = local.commons
  
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "tf_sg" {
  vpc_id      = aws_vpc.tf_vpc.id
  name        = "tf sg"
  description = "Grupo de seguridad para la subnet publica"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}