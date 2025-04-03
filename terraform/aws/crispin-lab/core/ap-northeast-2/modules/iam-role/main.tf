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

resource "aws_iam_role" "this" {
  name                 = var.iam_role_name
  assume_role_policy   = var.assume_role_policy
  max_session_duration = var.max_session_duration
}
