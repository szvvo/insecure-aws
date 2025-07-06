# /modules/s3_insecure_setup/outputs.tf

output "public_read_bucket_name" {
description = "The name of the S3 bucket that is publicly readable."
value       = aws_s3_bucket.public_read_bucket.bucket
}

