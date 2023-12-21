#s3 static website conf
resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = data.aws_s3_bucket.selected-bucket1.id
index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "website-config2" {
  bucket = data.aws_s3_bucket.selected-bucket2.id

  redirect_all_requests_to {
    host_name = "${var.domain_name}"
    protocol = "https"
  }
}


