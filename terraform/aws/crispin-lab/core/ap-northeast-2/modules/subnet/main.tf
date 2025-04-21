resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block
  tags                    = var.subnet_tags
  availability_zone       = var.subnet_availability_zone
  map_public_ip_on_launch = var.is_map_public_ip_on_launch
}
