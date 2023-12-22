#S3 first bucket
resource "aws_s3_bucket_ownership_controls" "example" {
  depends_on = [
    aws_s3_bucket.bucket-1,
  ]
  bucket = "${var.bucket_name}"
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = "${var.bucket_name}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = "${var.bucket_name}"
  acl    = "public-read"
}

#S3 second bucket
resource "aws_s3_bucket_ownership_controls" "example2" {
  depends_on = [
    aws_s3_bucket.bucket-2,
  ]
  bucket = "${var.sub_bucket_name}"
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example2" {
  bucket = "${var.sub_bucket_name}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "example2" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example2,
    aws_s3_bucket_public_access_block.example2,
  ]

  bucket = "${var.sub_bucket_name}"
  acl    = "public-read"
}