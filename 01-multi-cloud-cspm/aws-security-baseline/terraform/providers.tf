# providers.tf
# Investment Banking Cloud Security - AWS Provider Configuration

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "InvestmentBankCloudSecurity"
      ManagedBy   = "Terraform"
      Owner       = "Deji-Ewuola"
      Environment = "Production"
      Compliance  = "Banking-Standards"
    }
  }
}
