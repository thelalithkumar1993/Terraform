resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "lalithbuckets3"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
