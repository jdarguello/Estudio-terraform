terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">=5.3.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    region = "eu-west-1"
    alias = "eu_west"
}

resource "aws_s3_bucket" "tf_us_east" {
    bucket = "jdarguel-s3-us"
}

resource "aws_s3_bucket" "tf_eu_west" {
    bucket = "jdarguel-s3-eu"
    provider = aws.eu_west
}
