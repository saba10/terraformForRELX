terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

provider "random" {
  #since random provider does not required any provider specific configuration, it is not required to configure this. 
}

resource "random_integer" "random_int" {
  min = 10000
  max = 99999
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "static-web-hosting-saba-${random_integer.random_int.result}"
  force_destroy = true

  tags = {
    project = "RELX"
  }

}

##DATA##
data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"]
  }
}
##

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.iam_policy_document.json
}

resource "aws_s3_object" "s3_objects" {
  for_each = {
    index = "index.html"
    error = "error.html"
  }

  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = each.value
  source = "./${each.value}"
  content_type = "text/html"
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.s3_bucket.id

  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}