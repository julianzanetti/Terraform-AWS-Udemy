# Terraform Command Basics.
## Understand Terraform Workflow using Terraform Commands.
- **Terraform init:** Used to initialize a working directory containing terraform config files.
- **Terraform validate:** Validates the terraform configuration files in that respective directory to ensure they're syntactically valid and internally consistent. 
- **Terraform plan:** Creates an execution plan. Terraform performs a refresh and determines what actions are necessary to achieve the desired state specified in configuration files.
- **Terraform apply:** Used to apply the changes required to reach the desired state of the configuration. By default, apply scans the current directory for the configuration and applies the changes appropriately.
- **Terraform destroy:** Used to destroy the Terraform-managed infrastructure. This will ask for confirmation before destroying.
![image](https://github.com/user-attachments/assets/1d213241-c7f5-472f-83fd-54af1513ad9c)

## Review terraform manifest for EC2 Instance.
- **Pre-Conditions-1:** Ensure you have default-vpc in that respective region
- **Pre-Conditions-2:** Ensure AMI you are provisioning exists in that region if not update AMI ID
- **Pre-Conditions-3:** Verify your AWS Credentials in **$HOME/.aws/credentials**
```
# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "sa-east-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0b949884b7ebca5ff" # Amazon Linux 2 in sa-east-1, update as per your region
  instance_type = "t2.micro"
}
```
