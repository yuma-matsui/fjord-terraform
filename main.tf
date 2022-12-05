# ----------------------------
# Teffaform configuration
# ----------------------------
terraform {
  required_version = ">=1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.45.0"
    }
  }
  backend "s3" {
    bucket  = "fjord-terraform-tfstate-bucket"
    key     = "fjord-terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "terraform"
  }
}

# ----------------------------
# Provider
# ----------------------------
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# ----------------------------
# variables
# ----------------------------
variable "project" {
  type = string
}
