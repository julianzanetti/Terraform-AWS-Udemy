# Terraform Configuration Language Syntax
- [Terraform Configuration](https://developer.hashicorp.com/terraform/language)
- [Terraform Configuration Syntax](https://developer.hashicorp.com/terraform/language/syntax/configuration)
```
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS Example
resource "aws_instance" "ec2demo" { # BLOCK
  ami           = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf
}
```

## Understand about Arguments, Attributes and Meta-Arguments.
- Arguments can be required or optional
- Attribues format looks like resource_type.resource_name.attribute_name
- Meta-Arguments change a resource type's behavior (Example: count, for_each)
- [Resource: AWS Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attribute-reference)
- [Resource: Meta-Arguments](https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on)

## Understand about Terraform Top-Level Blocks.
![image](https://github.com/user-attachments/assets/45b1ba03-285f-48b8-8746-c4b161c7a137)

- ### Manifest.tf example.
```
#####################################################################
# Block-1: Terraform Settings Block
terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage with State Locking
  backend "s3" {
    bucket = "terraform-stacksimplify"
    key    = "dev2/terraform.tfstate"
    region = "us-east-1"  

    # For State Locking
    dynamodb_table = "terraform-dev-state-table"
  }
}
#####################################################################
# Block-2: Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}
#####################################################################
# Block-3: Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-04d29b6f966df1537" # Amazon Linux
  instance_type = var.instance_type
}
#####################################################################
# Block-4: Input Variables Block
variable "instance_type" {
  default = "t2.micro"
  description = "EC2 Instance Type"
  type = string
}
#####################################################################
# Block-5: Output Values Block
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.my-ec2-vm.public_ip
}
#####################################################################
# Block-6: Local Values Block
# Create S3 Bucket - with Input Variables & Local Values
locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}
#####################################################################
# Block-7: Data sources Block
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}
#####################################################################
# Block-8: Modules Block
# AWS EC2 Instance Module

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  #instance_count         = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-08b25c5a5bf489ffa"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-4ee95470" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
#####################################################################
```
