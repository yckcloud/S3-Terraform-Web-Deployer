#S3 bucket configuration

#First bucket
resource "aws_s3_bucket" "bucket-1" {
  bucket = "${var.bucket_name}"
}
data "aws_s3_bucket" "selected-bucket1" {
  bucket = aws_s3_bucket.bucket-1.bucket
}


#Second bucket
resource "aws_s3_bucket" "bucket-2" {
  bucket = "${var.sub_bucket_name}"
}
data "aws_s3_bucket" "selected-bucket2" {
  bucket = aws_s3_bucket.bucket-2.bucket
}

