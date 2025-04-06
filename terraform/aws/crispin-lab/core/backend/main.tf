terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.default_aws_region
}

module "terraform_state_bucket" {
  source      = "./modules/s3"
  bucket_name = "crispin-lab-terraform-states"
  bucket_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDevOpsRoleAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DevOps"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::crispin-lab-terraform-states",
          "arn:aws:s3:::crispin-lab-terraform-states/*"
        ]
      },
      {
        Sid       = "DenyAllExceptDevOpsRole"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "arn:aws:s3:::crispin-lab-terraform-states",
          "arn:aws:s3:::crispin-lab-terraform-states/*"
        ]
        Condition = {
          StringNotEquals = {
            "aws:PrincipalArn" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DevOps"
          }
        }
      }
    ]
  })
  logging_bucket_name = "crispin-lab-terraform-states-logging"
}

module "terraform_state_log_bucket" {
  source      = "./modules/s3"
  bucket_name = "crispin-lab-terraform-states-logging"
  bucket_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDevOpsRoleAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DevOps"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::crispin-lab-terraform-states-logging",
          "arn:aws:s3:::crispin-lab-terraform-states-logging/*"
        ]
      },
      {
        Sid       = "DenyAllExceptDevOpsRole"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "arn:aws:s3:::crispin-lab-terraform-states-logging",
          "arn:aws:s3:::crispin-lab-terraform-states-logging/*"
        ]
        Condition = {
          StringNotEquals = {
            "aws:PrincipalArn" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DevOps"
          }
        }
      }
    ]
  })
  logging_bucket_name = "crispin-lab-terraform-states-logging"
}

module "terraform_lock_table" {
  source      = "./modules/dynamodb"
  table_name  = "terraform-locks"
  devops_role = "DevOps"
}

output "s3_bucket_name" {
  value = module.terraform_state_bucket.bucket_name
}

output "dynamodb_table_name" {
  value = module.terraform_lock_table.table_name
}
