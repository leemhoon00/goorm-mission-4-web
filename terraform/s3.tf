data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "web" {
  bucket = var.s3_name
}

resource "aws_s3_bucket_cors_configuration" "web" {
  bucket = aws_s3_bucket.web.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_acl" "web" {
  bucket     = aws_s3_bucket.web.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.web]
}

resource "aws_s3_bucket_ownership_controls" "web" {
  bucket = aws_s3_bucket.web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.web]
}

resource "aws_s3_bucket_public_access_block" "web" {
  bucket = aws_s3_bucket.web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Principal = {
          "Service" : "cloudfront.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.s3_name}",
          "arn:aws:s3:::${var.s3_name}/*"
        ]
        Condition = {
          "StringEquals" : {
            "aws:SourceArn" : "arn:aws:cloudfront::${local.account_id}:distribution/${aws_cloudfront_distribution.web.id}}"
          }
        }
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.web]
}
