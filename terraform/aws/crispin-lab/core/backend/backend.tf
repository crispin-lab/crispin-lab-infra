terraform {
  backend "s3" {
    bucket         = "crispin-lab-terraform-states"
    key            = "crispin-lab/core/backend/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
