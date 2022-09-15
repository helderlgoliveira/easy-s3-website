output "s3_bucket_arn" {
  value = aws_s3_bucket.website.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.website.id
}

output "s3_domain_name" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_domain
}

output "s3_website_url" {
  value = "http://${aws_s3_bucket.website.id}.s3-website-${var.aws_region}.amazonaws.com"
}
