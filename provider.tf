terraform {
  backend "s3" {
    bucket = "polaris-terraform-s3-latest"
    key    = "polaris/terraform.tfstate"
    region = "ap-south-1"
  }
}


provider "aws" {
  region = "ap-south-1"
}
