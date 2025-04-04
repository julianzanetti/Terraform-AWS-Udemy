# Terraform Small Utility Project
## Current Problem:
- We are not able to create EC2 Instances in all the subnets of our VPC which are spread across all availability zones in that region.
- We need to find a solution to say that our desired EC2 Instance Type **`example: t2.micro`** is supported in that availability zone or not

## Set-up the file c1-versions.tf
- Hard-coded the region as we are not going to use any variables.tf in this utility project
```
# Terraform Block
terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "sa-east-1"
}
```

## File c2-v1-get-instancetype-supported-per-az-in-a-region.tf
- We are first going to explore the datasource and it outputs
```
aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t2.micro --region sa-east-1 --output table
```
![image](https://github.com/user-attachments/assets/bbf83570-56a5-4cac-87fa-4c4b78ba0c57)
> [!NOTE]
> Missing AZ sa-east-1b

- ### Create the datasource and its output.
```
# Datasource
data "aws_ec2_instance_type_offerings" "my_ins_type1" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = ["sa-east-1a"]
    #values = ["sa-east-1b"]    
  }
  location_type = "availability-zone"
}


# Output
output "output_v1_1" {
 value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}
```
![image](https://github.com/user-attachments/assets/bd0e4eb9-4d16-4f1a-8ebb-e8ad2536a788)
![image](https://github.com/user-attachments/assets/99728236-93cf-445c-aaa5-fcececa6c63e)
> [!NOTE]
> Output have the instance value empty `[]` when `values = ["sa-east-1b"]` in location filter

## File c2-v2-get-instancetype-supported-per-az-in-a-region.tf
