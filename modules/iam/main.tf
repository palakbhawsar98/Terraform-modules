provider "aws" {
  region = "us-east-1"
}

#Create iam user and provide s3 full access
resource "aws_iam_user" "s3_access" {
  name = var.iam_user_name

  tags = {
    project = "terraform_iam_module"
    name    = "iam_s3_full_access"
  }

}

resource "aws_iam_policy" "iam_policy" {
  name = var.iam_policy_name
  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"s3:*"
			],
			"Resource": [
				"arn:aws:s3:::${var.bucket_name}",
				"arn:aws:s3:::${var.bucket_name}/*"
			]
		}
	]
})
}

resource "aws_iam_user_policy_attachment" "policy_attach" {
  user       = aws_iam_user.s3_access.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

# Allow EC2 instance to assume this role
resource "aws_iam_role" "role_to_access_s3" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
	Version = "2012-10-17"
	Statement = [{
		Effect = "Allow"
		Principal = {
			Service = "ec2.amazonaws.com"
		}
		Action = "sts:AssumeRole"
	}]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
	role = aws_iam_role.role_to_access_s3.name
	policy_arn = aws_iam_policy.iam_policy.arn
}