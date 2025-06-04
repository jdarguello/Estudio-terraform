terraform {
    required_version = ">=1.5.0"

    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.3.0"
      }

      random = {
        source = "hashicorp/random"
        version = "~> 3.0"
      }
    }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "random_value" {
  byte_length = 6
}

resource "aws_s3_bucket" "tf_example_bucket" {
    bucket = "tf-bucket-${random_id.random_value.hex}"   
}

output "bucket_name" {
  value = aws_s3_bucket.tf_example_bucket.bucket
}