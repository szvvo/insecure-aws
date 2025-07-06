

# output "create_user_access_keys" {
#   description = "AWS CLI command to create access keys for the insecure user"
#   value = "aws iam create-access-key --user-name ${module.iam_insecure_setup.aws_iam_user.name}"
# }

# all modules outputs

# iam_insecure_setup
# aws access key
 output "aws_access_key" {
  description = "AWS access key"
  value = module.iam_insecure_setup.aws_iam_user.name
 }
