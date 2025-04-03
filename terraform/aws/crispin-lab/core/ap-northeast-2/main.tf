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

module "devops_user" {
  source    = "./modules/iam"
  user_name = "crispin"
}

module "developer_user" {
  source    = "./modules/iam"
  user_name = "dev_crispin"
}
