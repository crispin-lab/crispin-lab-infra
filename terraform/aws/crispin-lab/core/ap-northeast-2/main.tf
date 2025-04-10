terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region = var.default_aws_region
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
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
  source               = "./modules/iam-role"
  iam_role_name        = "DevOps"
  max_session_duration = 28800
  assume_role_policy = templatefile(
    "${path.root}/modules/iam-role/policies/devops-trust.json.tftpl",
  { account_id = local.account_id })
}

module "developer_role" {
  source               = "./modules/iam-role"
  iam_role_name        = "Developer"
  max_session_duration = 43200
  assume_role_policy = templatefile(
    "${path.root}/modules/iam-role/policies/developer-trust.json.tftpl",
    { account_id = local.account_id }
  )
}

module "github_oidc_provider" {
  source = "./modules/github-oidc-provider"
}

module "github_actions_role" {
  source               = "./modules/iam-role"
  iam_role_name        = "GitHubActions"
  max_session_duration = 3600
  assume_role_policy = templatefile(
    "${path.root}/modules/iam-role/policies/github-oidc-trust.json.tftpl",
    { github_oidc_provider_arn = module.github_oidc_provider.arn }
  )
}

module "github_actions_iam_policy" {
  source                 = "./modules/iam-policy"
  iam_policy_name        = "GitHubActionsIAMPermissions"
  iam_policy_description = "Required IAM permissions for GitHub Actions"
  iam_policy = templatefile(
    "${path.root}/modules/iam-policy/policies/github-actions.json.tftpl",
    {}
  )
}

module "iam_role_policy_attachment" {
  source         = "./modules/iam-attachment"
  iam_role_name  = "GitHubActions"
  iam_policy_arn = module.github_actions_iam_policy.policy_arn
}

module "ap_northeast_2_kms_key" {
  source              = "./modules/kms"
  kms_key_description = "Default KMS key"
  kms_key_tags = {
    Name = "ap-northeast-2-kms-key"
  }
  kms_key_policy = templatefile(
    "${path.root}/modules/kms/policies/cloudwatch-kms.json.tftpl",
    {}
  )
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
  kms_key_id     = module.ap_northeast_2_kms_key.arn
}

module "vpc_flow_log_role" {
  source        = "./modules/iam-role"
  iam_role_name = "VpcFlowLog"
  assume_role_policy = templatefile(
    "${path.root}/modules/iam-role/policies/flow-log-trust.json.tftpl",
    {}
  )
}

module "vpc_flow_log_role_policy" {
  source                 = "./modules/iam-policy"
  iam_policy_name        = "VpcFlowLogPermissions"
  iam_policy_description = "Flow log policy"
  iam_policy = templatefile(
    "${path.module}/modules/iam-policy/policies/flow-log.json.tftpl",
    {}
  )
}

module "vpc_flow_log" {
  source                    = "./modules/flow-log"
  iam_role_arn              = module.vpc_flow_log_role.arn
  flow_log_destination      = module.cloudwatch_log_group.arn
  flow_log_destination_type = "cloud-watch-logs"
  vpc_id                    = module.crispin-lab-vpc.id
}
