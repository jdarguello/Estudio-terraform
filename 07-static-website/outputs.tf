output "s3_website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.tf_static_website.website_endpoint}"
}