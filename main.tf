locals {
  content = "${timestamp()}"
}

resource "aws_s3_bucket_object" "test1"{
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "test1.txt"
  content      = local.content
  content_type = "text/plain"
}
resource "aws_s3_bucket_object" "test2"{
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "test2.txt"
  content      = local.content
  content_type = "text/plain"
}