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

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Principal = "*"
        Action = [
          "s3:*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.s3_name}",
          "arn:aws:s3:::${var.s3_name}/*"
        ]
      },
      {
        Sid       = "PublicReadGetObject"
        Principal = "*"
        Action = [
          "s3:GetObject",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.s3_name}",
          "arn:aws:s3:::${var.s3_name}/*"
        ]
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.web]
}
