locals {
  bucket_name = replace(format("%.63s", var.bucket_name), "_", "-")
}
resource "aws_s3_bucket" "bucket" {
  force_destroy = false
  bucket        = local.bucket_name
  acl           = "private"

  versioning {
    enabled    = var.versioning
  }

  tags = {
    Name        = local.bucket_name
  }
}