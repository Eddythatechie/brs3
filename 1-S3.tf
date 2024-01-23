resource "aws_s3_bucket" "suns3" {
  bucket = "suns3"

  tags = {
    Name        = "suns3"
  }
}

resource "aws_s3_bucket_versioning" "versioning_suns3" {
  bucket = aws_s3_bucket.suns3.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "suns3" {
  bucket = aws_s3_bucket.suns3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "suns3" {
  bucket = aws_s3_bucket.suns3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "suns3" {
  depends_on = [
    aws_s3_bucket_ownership_controls.suns3,
    aws_s3_bucket_public_access_block.suns3,
  ]

  bucket = aws_s3_bucket.suns3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "text_file" {
  bucket = "suns3"
  key    = "index.html"
  acl = "public-read"
  source = "/Users/paul/Documents/s3hw/index.html"
}

resource "aws_s3_bucket_object" "brazil1pic" {
  bucket = "suns3"
  key    = "brazil1.jpeg"
  acl = "public-read"
  source = "/Users/paul/Documents/s3hw/brazil1.jpeg"
}