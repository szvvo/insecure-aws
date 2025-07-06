# /modules/iam_insecure_setup/variables.tf

variable "user_name" {
  description = "The name for the insecure IAM user."
  type        = string
  default     = "demo-admin-user"
}

variable "role_name" {
  description = "The name for the insecure IAM role."
  type        = string
  default     = "insecure-admin-role"
}