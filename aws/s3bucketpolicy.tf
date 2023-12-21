#S3 Bucket policy configuration
resource "aws_s3_bucket_policy" "bucket_policy" {
   depends_on = [
    aws_s3_bucket.bucket-1,
  ]
  bucket = "${var.bucket_name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "bucket_policy2" {
  depends_on = [
    aws_s3_bucket.bucket-2,
  ]
  bucket = "${var.sub_bucket_name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.sub_bucket_name}/*"
    }
  ]
}
POLICY
}