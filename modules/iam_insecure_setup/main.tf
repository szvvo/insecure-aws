// ------------------------------------------------------------------
// MODULES DIRECTORY: ./modules/iam_insecure_setup/main.tf
// This is the main file for our module. It defines the insecure
// IAM user and IAM role.
// ------------------------------------------------------------------

// --- Insecure IAM User ---
// This user is created and directly attached to the AdministratorAccess policy.
// This violates the principle of least privilege. A real-world user should
// only have the permissions necessary for their specific tasks.

resource "aws_iam_user" "insecure_user" {
    name = var.user_name
}


resource "aws_iam_user_policy_attachment" "admin_policy_attachement" {
    user = aws_iam_user.insecure_user.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.insecure_user.name
}


// --- Insecure IAM Role ---
// This role has a trust policy that allows ANY AWS principal (users, roles, services)
// in the account to assume it. This is extremely dangerous. A proper trust policy

// would specify the exact principal ARN(s) that are allowed to assume the role.

resource "aws_iam_role" "insecure_role" {
    name = var.role_name
    assume_role_policy = data.aws_iam_policy_document.insecure_trust_policy.json

}

resource "aws_iam_role_policy_attachment" "role_admin_policy_attachment" {
  role       = aws_iam_role.insecure_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


data "aws_iam_policy_document" "insecure_trust_policy" {
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals {
          type = "AWS"

           // "identifiers" is set to the account's root. This means any authenticated
           // entity within this AWS account can assume this role.
          identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
    
    }  
}

data "aws_caller_identity" "current" {
  
}