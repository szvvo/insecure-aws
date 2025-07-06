# /modules/iam_insecure_setup/outputs.tf

output "insecure_user_name" {
  description = "The name of the insecure IAM user with admin privileges."
  value       = aws_iam_user.insecure_user.name
}

output "insecure_user_access_key_id" {
  description = "The access key ID for the insecure user. Treat this as a secret."
  value       = aws_iam_access_key.user_key.id
}

output "insecure_user_secret_access_key" {
  description = "The secret access key for the insecure user. TREAT THIS AS A SECRET!."
  value       = aws_iam_access_key.user_key.secret
}

output "insecure_role_arn" {
  description = "The ARN of the insecure role that can be assumed by any principal in the account."
  value       = aws_iam_role.insecure_role.arn
}
