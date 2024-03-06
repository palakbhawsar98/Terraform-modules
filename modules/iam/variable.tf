variable "iam_user_name" {
  type    = string
  default = "iam_user_s3"
}

variable "iam_policy_name" {
  type    = string
  default = "iam_s3_access_policy"
}

variable "bucket_name" {
  type    = string
  default = "test_bucket_980"
}