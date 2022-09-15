terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_s3_bucket" "website" {
  bucket        = var.bucket_name
  tags          = var.bucket_tags
  force_destroy = true
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
}

data "aws_iam_policy_document" "s3_website_bucket_policy" {
  statement {
    sid     = "PublicRead"
    effect  = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.website.arn}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }

  }
}

resource "aws_s3_bucket_policy" "s3_website_bucket_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_website_bucket_policy.json
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = var.website_index_file
  }

  error_document {
    key = var.website_error_file
  }
}

module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = var.website_files_path
}

resource "aws_s3_object" "website_files" {
  for_each = module.template_files.files

  source       = each.value.source_path
  content_type = each.value.content_type
  bucket       = var.bucket_name
  key          = each.key
  etag         = each.value.digests.md5

  depends_on = [
    aws_s3_bucket.website
  ]
}
