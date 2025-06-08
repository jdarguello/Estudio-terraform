output "ec2_arn" {
  value = aws_instance.tf_ec2.arn
  description = "ARN de la instancia EC2"
}