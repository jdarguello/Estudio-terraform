variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ec2_type" {
  type    = string

  validation {
    condition     = var.ec2_type == "t2.micro" || var.ec2_type == "t3.micro"
    error_message = "Debe ser t2.micro o t3.micro"
  }
}

variable "ec2_volume_config" {
  type    = object({
    size = number
    type = string
  })

  validation {
    condition     = contains(["gp2", "gp3"], var.ec2_volume_config.type)
    error_message = "Debe ser 'gp2' o 'gp3'"
  }
}