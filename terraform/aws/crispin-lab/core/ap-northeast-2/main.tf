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
          "s3:GetBucketLogging",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketTagging",
          "s3:GetBucketPublicAccessBlock"
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

module "crispin-lab-vpc" {
  source = "./modules/vpc"
  vpc_tags = {
    Name = "crispin-lab-vpc"
  }
}

module "cloudwatch_log_group" {
  source         = "./modules/cloudwatch"
  log_group_name = "/aws/vpc/${module.crispin-lab-vpc.name_prefix}-flow-logs"
  retention_days = 7
  kms_key_id     = module.ap_northeast_2_kms_key.id
}

module "vpc_flow_log_role" {
  source        = "./modules/iam-role"
  iam_role_name = "${module.crispin-lab-vpc.name_prefix}-vpc-flow-log-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

module "vpc_flow_log_role_policy" {
  source                 = "./modules/iam-policy"
  iam_policy_description = "IAM policy attached to resources"
  iam_policy_name        = "${module.crispin-lab-vpc.name_prefix}-vpc-flow-log-policy"
  iam_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = module.cloudwatch_log_group.arn
      },
    ]
  })
}

module "vpc_flow_log" {
  source                    = "./modules/flow-log"
  iam_role_arn              = module.vpc_flow_log_role.arn
  flow_log_destination      = module.cloudwatch_log_group.arn
  flow_log_destination_type = "cloud-watch-logs"
  vpc_id                    = module.crispin-lab-vpc.id
}

module "ap_northeast_2_kms_key" {
  source = "./modules/kms"
  kms_key_tags = {
    "Name" = "ap-northeast-2-kms-key"
  }
  kms_key_description = "Default KMS key"
  kms_key_policy = jsonencode({
    Version = "2012-10-17"
    Id      = "CloudWatch-KMS-Key-Policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CloudWatch to use the key"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.default_aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          ArnLike = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:${var.default_aws_region}:${local.account_id}:*"
          }
        }
      }
    ]
  })
}
