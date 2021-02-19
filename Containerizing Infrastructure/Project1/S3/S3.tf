resource "aws_s3_bucket" "b" {
  bucket = "nginx-web-server-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
