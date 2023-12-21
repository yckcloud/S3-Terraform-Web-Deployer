#S3 versioning for both buckets
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = data.aws_s3_bucket.selected-bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example2" {
  bucket = data.aws_s3_bucket.selected-bucket2.id
  versioning_configuration {
    status = "Enabled"
  }
}