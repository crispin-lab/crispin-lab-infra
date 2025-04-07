terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  account_id = sensitive(data.aws_caller_identity.current.account_id)
}

provider "aws" {
  region = var.default_aws_region
}

module "devops_user" {
  source    = "./modules/iam-user"
  user_name = "crispin"
}

module "developer_user" {
  source    = "./modules/iam-user"
  user_name = "dev_crispin"
}

module "devops_role" {
  source        = "./modules/iam-role"
  iam_role_name = "DevOps"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::${local.account_id}:user/crispin"
          }
          Sid = "DevOpsSts"
        },
      ]
      Version = "2012-10-17"
    }
  )
  max_session_duration = 28800
}

module "developer_role" {
  source        = "./modules/iam-role"
  iam_role_name = "Developer"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::${local.account_id}:user/dev_crispin"
          }
          Sid = "DeveloperSts"
        },
      ]
      Version = "2012-10-17"
    }
  )
  max_session_duration = 43200
}

module "github_oidc_provider" {
  source = "./modules/github-oidc-provider"
}

module "github_actions_role" {
  source        = "./modules/iam-role"
  iam_role_name = "GitHubActions"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.github_oidc_provider.arn
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:crispin-lab/crispin-lab-be:*",
              "repo:crispin-lab/crispin-lab-fe:*",
              "repo:crispin-lab/crispin-lab-infra:*",
            ]
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
  max_session_duration = 3600
}

module "github_actions_iam_policy" {
  source                 = "./modules/iam-policy"
  iam_policy_name        = "GitHubActionsIAMPermissions"
  iam_policy_description = "Required IAM permissions for GitHub Actions"
  iam_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:GetOpenIDConnectProvider",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:TagOpenIDConnectProvider"
        ]
        Resource = "arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:PutRolePolicy",
          "iam:GetRolePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "iam:TagRole"
        ]
        Resource = [
          "arn:aws:iam::${local.account_id}:role/Developer",
          "arn:aws:iam::${local.account_id}:role/DevOps"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetUser",
          "iam:CreateUser",
          "iam:DeleteUser",
          "iam:TagUser",
          "iam:PutUserPolicy",
          "iam:AttachUserPolicy",
          "iam:DetachUserPolicy"
        ]
        Resource = [
          "arn:aws:iam::${local.account_id}:user/dev_crispin",
          "arn:aws:iam::${local.account_id}:user/crispin"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:ListPolicies",
          "iam:GetPolicy",
          "iam:GetPolicyVersion"
        ]
        Resource = "arn:aws:iam::${local.account_id}:policy/*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies"
        ]
        Resource = [
          "arn:aws:iam::${local.account_id}:role/GitHubActions"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetBucketPolicy",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketLogging"
        ],
        Resource = [
          "arn:aws:s3:::crispin-lab-terraform-states",
          "arn:aws:s3:::crispin-lab-terraform-states-logging"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "arn:aws:kms:ap-northeast-2:${local.account_id}:key/*",
        Condition = {
          StringEquals = {
            "kms:ResourceTag/Name" = "aws-s3-dynamodb-kms-key"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "kms:GetKeyPolicy",
          "kms:GetKeyRotationStatus",
          "kms:ListResourceTags",
        ],
        Resource = "arn:aws:kms:ap-northeast-2:${local.account_id}:key/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:DescribeTable",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListTagsOfResource"
        ],
        "Resource" : "arn:aws:dynamodb:ap-northeast-2:${local.account_id}:table/terraform-locks"
      }
    ]
  })
}

module "iam_role_policy_attachment" {
  source         = "./modules/iam-attachment"
  iam_role_name  = "GitHubActions"
  iam_policy_arn = module.github_actions_iam_policy.policy_arn
}
