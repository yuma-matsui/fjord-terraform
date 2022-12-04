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
