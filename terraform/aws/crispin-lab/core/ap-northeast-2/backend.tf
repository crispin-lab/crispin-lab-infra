terraform {
  backend "s3" {
    bucket         = "crispin-lab-terraform-states"
    key            = "crispin-lab/core/ap-northeast-2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
