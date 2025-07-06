
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