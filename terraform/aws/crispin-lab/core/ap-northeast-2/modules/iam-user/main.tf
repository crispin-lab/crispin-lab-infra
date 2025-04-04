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

resource "aws_iam_user" "this" {
  name = var.user_name
}
