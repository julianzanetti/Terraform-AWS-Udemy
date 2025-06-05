# Terraform Block
terraform {
  required_version = "~> 1.10" # Nos permite trabajar con versiones posteriores, ej: 1.10.5 o 1.10.6 pero no la 1.11.0.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = sa-east-1
}