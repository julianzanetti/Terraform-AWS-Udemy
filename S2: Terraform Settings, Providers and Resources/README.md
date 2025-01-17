# EC2 Instance using Terraform and provision a webserver with userdata.
## Create Terraform Settings Block.
- [Terraform Settings Block](https://developer.hashicorp.com/terraform/language/terraform)
- Create c1-versions.tf y complete with your Terraform Block.
```
# Terraform Block
terraform {
  required_version = "~> 1.10.4" # Nos permite trabajar con versiones posteriores, ej: 1.10.5 o 1.10.6 pero no la 1.11.0.
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
```

## Create Terraform Providers Block.
- [Terraform Providers](https://developer.hashicorp.com/terraform/language/providers)
- Complete in c1-versions.tf with your Provider Block.
```
# Provider Block
provider "aws" {
  region  = sa-east-1
  profile = "default"
}
```
> [!NOTE]
> Remember configure AWS Credentials in the AWS CLI if not configured
```
# Verify AWS Credentials
cat $HOME/.aws/credentials
```
