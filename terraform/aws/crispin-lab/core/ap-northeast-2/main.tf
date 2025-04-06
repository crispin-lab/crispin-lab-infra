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
            AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/crispin"
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
            AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/dev_crispin"
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
