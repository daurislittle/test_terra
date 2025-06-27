// modules->s3->output

output "bucket_id" {
  description = "S3 bucket name id"
  value = aws_s3_bucket.this.arn
}

output "bucket_arn" {
  description = "Arn of the s3 bucket"
  value = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Dns domain name of the bucket"
  value = aws_s3_bucket.this.bucket_domain_name
}