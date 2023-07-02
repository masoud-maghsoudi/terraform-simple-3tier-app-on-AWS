resource "aws_s3_bucket" "app-bucket" {
  bucket = "app-bucket-202305122028"

  tags = {
    Name = "app-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "app-bucket-public-access-block" {
  bucket = aws_s3_bucket.app-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "app-bucket-ownership" {
  depends_on = [aws_s3_bucket_public_access_block.app-bucket-public-access-block]
  bucket     = aws_s3_bucket.app-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "app-bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.app-bucket-ownership]
  bucket     = aws_s3_bucket.app-bucket.id
  acl        = "public-read"
}

