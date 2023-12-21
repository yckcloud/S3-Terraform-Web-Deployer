#S3 upload folder conf with content types
locals {
  content_type_map = {
   "js" = "application/json"
   "html" = "text/html"
   "css"  = "text/css"
   "avif" = "image/avif"
  }
}
resource "aws_s3_object" "object-upload" {
  depends_on = [
    aws_s3_bucket.bucket-1,
  ]
  for_each     = fileset("uploads/", "**/*")
  bucket       = "${var.bucket_name}"
  key          = each.value
  source       = "uploads/${each.value}"
  etag         = filemd5("uploads/${each.value}")
  content_type = lookup(local.content_type_map, split(".", "${each.value}")[1], "text/html")

}






