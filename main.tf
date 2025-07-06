# ================== Initial Setup ==================== #
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project = "Insecure AWS Infrastructure" 
    }
  }
}

module "iam_insecure_setup" {
  source = "./modules/iam_insecure_setup"
  user_name = "insecure-user"
  role_name = "insecure_role"
}

module "storage_insecure_setup" {
    source = "./modules/storage_insecure_setup"
    // modify storage prefix
    bucket_prefix = "non-chalant"
}

