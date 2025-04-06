resource "aws_kms_key" "dynamo_db_kms" {
  enable_key_rotation = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamo_db_kms.arn
  }

  point_in_time_recovery {
    enabled = true
  }
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "TerraformDynamoDBAccess"
  description = "Policy for accessing Terraform lock table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = aws_dynamodb_table.terraform_locks.arn
      }
    ]
  })
}

data "aws_iam_role" "devops" {
  name = var.devops_role
}

data "aws_iam_role" "github_actions" {
  name = var.github_actions_role
}

resource "aws_iam_role_policy_attachment" "terraform_dynamodb_attach_for_devops" {
  role       = data.aws_iam_role.devops.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_role_policy_attachment" "terraform_dynamodb_attach_for_github_actions" {
  role       = data.aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}
