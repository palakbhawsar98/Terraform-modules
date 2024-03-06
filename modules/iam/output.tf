output "iam-user-name" {
    description = "Name of the IAM user"
    value = aws_iam_user.s3_access.name
}

output "iam_policy_arn" {
  description = "ARN of the IAM policy attached to the user"
  value       = aws_iam_policy.iam_policy.arn
}