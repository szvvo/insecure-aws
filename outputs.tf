
# outputs.tf

output "insecure_user_credentials" {
  description = "Credentials for the over-privileged IAM user. Do not use in production."
  value = {
    user_name         = module.iam_insecure_setup.insecure_user_name
    access_key_id     = module.iam_insecure_setup.insecure_user_access_key_id
    secret_access_key = module.iam_insecure_setup.insecure_user_secret_access_key
  }
   sensitive = true
}

output "insecure_role_arn" {
  description = "ARN of the dangerously assumable admin role."
  value       = module.iam_insecure_setup.insecure_role_arn
}

// insecure bucket config

output "insecure_s3_bucket_names" {
description = "A list of the insecure S3 buckets created for the demo."
value = {
publicly_readable = module.storage_insecure_setup.public_read_bucket_name
    }
}

// insecure networking config

output "insecure_networking" {
    description = "Networking details"
    value = {
       vpcid = module.networking-insecure_setup.vpc_id,
       public_subnets =  module.networking-insecure_setup.public_subnet_ids,
       insecure_sg = module.networking-insecure_setup.insecure_security_group_id
    }
}
