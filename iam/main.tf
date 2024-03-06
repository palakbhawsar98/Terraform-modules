provider "aws" {
  region = "us-east-1"
}

module "iam_user_with_s3_perm" {
  source          = "../modules/iam"
  iam_user_name   = var.iam_user_name
  iam_policy_name = var.iam_policy_name 
  bucket_name     = var.bucket_name
} 