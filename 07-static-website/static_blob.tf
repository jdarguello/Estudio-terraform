locals {
  common_tags = {
    CreadoPor = "Terraform"
  }
}

resource "aws_s3_bucket" "tf_s3" {
  bucket = "tf-jdarguel-static-web"

  tags = merge(local.common_tags, {
    Name = "tf_s3"
  })
}

resource "aws_s3_bucket_public_access_block" "tf_s3_public_access" {
  bucket = aws_s3_bucket.tf_s3.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}


resource "aws_s3_bucket_policy" "tf_s3_policy" {
  bucket = aws_s3_bucket.tf_s3.id
  policy = data.aws_iam_policy_document.s3GetObject.json
}

data "aws_iam_policy_document" "s3GetObject" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.tf_s3.arn,
      "${aws_s3_bucket.tf_s3.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "tf_static_website" {
  bucket = aws_s3_bucket.tf_s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.tf_s3.id
  key    = "index.html"
  source = "static_files/index.html"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.tf_s3.id
  key    = "error.html"
  source = "static_files/error.html"
}


