#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs:exp:2025-05-08
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.is_enable_dns_support
  enable_dns_hostnames = var.is_enable_dns_hostnames
  tags                 = var.vpc_tags
}
