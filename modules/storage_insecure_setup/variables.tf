# /modules/s3_insecure_setup/variables.tf

variable "bucket_prefix" {
description = "A unique prefix to ensure S3 bucket names are not already taken."
type        = string
default     = "insecure-demo-bucket"
}