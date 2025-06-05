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

  backend "s3" {
    
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "tf_id" {
    byte_length = 6
}

resource "aws_s3_bucket" "bucket_example" {
    bucket = "tf-example-${random_id.tf_id.hex}"
}