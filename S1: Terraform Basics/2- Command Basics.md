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
![image](https://github.com/user-attachments/assets/b684e1cd-1df7-4287-b12f-e475249d4868)

## Execute Terraform core commands.
```
# Initialize Terraform
terraform init
```
![image](https://github.com/user-attachments/assets/bf9dcdc3-17ee-4283-8a08-7879ffe01040)

```
# Terraform Validate
terraform validate
```
![image](https://github.com/user-attachments/assets/14ca114b-b7a1-47ac-bc52-3f82bfc60c3c)

```
# Terraform Plan to Verify what it is going to create / update / destroy
terraform plan
```
![image](https://github.com/user-attachments/assets/7f185355-7fd9-48e8-8f42-5f4875e2cc0b)

```
# Terraform Apply to Create EC2 Instance
terraform apply 
```
![image](https://github.com/user-attachments/assets/2d90d685-e2f0-4091-ad26-c94fcc98b674)
![image](https://github.com/user-attachments/assets/1c69ad79-aea6-4c28-9887-4687ff51ee6c)

## Verify the EC2 Instance in AWS Management Console.
- Go to AWS Management Console -> Services -> EC2.
- Verify newly created EC2 instance.
![image](https://github.com/user-attachments/assets/1e0bb5a8-902a-468c-8951-73d53f9a883b)

## Destroy Infrastructure.
```
# Destroy EC2 Instance
terraform destroy
```
![image](https://github.com/user-attachments/assets/fdee6e80-63db-4c37-bbcb-73041e4cf657)
![image](https://github.com/user-attachments/assets/82063779-2243-4d92-a44e-1a63898bfcaf)
![image](https://github.com/user-attachments/assets/b20f41bc-1297-429c-a593-5bb0cc9eadfa)

```
# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
```
![image](https://github.com/user-attachments/assets/8d883b4c-3328-4602-8a95-ad2dada8af1a)
