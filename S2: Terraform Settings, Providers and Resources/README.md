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

> [!IMPORTANT]
> Remember configure AWS Credentials in the AWS CLI if not configured
```
# Verify AWS Credentials
cat $HOME/.aws/credentials
```

> [!NOTE]
> If you have more than one user configured in AWS Credentials, you can select which user to work with into the Provider Block.

## Create Resource Block.
- [Create EC2 Instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Understand about File Fuction "user_data"](https://developer.hashicorp.com/terraform/language/functions/file)
```
# Resource: EC2 Instance
resource "aws_instance" "mi_ec2" {
  ami = "ami-079a9eba298521f24"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
```

## Create app1-install.sh
```
#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome, this is an Example</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1Welcome, this is an Examplen</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
```
> [!NOTE]
> This is an example script in which we install apache and run it inside the Resource Block.

## Execute Terraform Commands.
- Our directory should look like this:

![image](https://github.com/user-attachments/assets/6d3bd654-d5a4-45e5-8990-e16e62eddbbd)

```
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply
[or]
terraform apply -auto-approve
```

## Access Application.
```
# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html

# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html
```

## Clean-Up.
```
# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
