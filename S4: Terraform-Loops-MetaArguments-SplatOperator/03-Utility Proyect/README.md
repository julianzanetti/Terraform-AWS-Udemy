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
- Using `for_each` create multiple instances of datasource and loop it with hard-coded availability zones in for_each
- ## Create the datasource and its output.
```
data "aws_ec2_instance_type_offerings" "my_ins_type2" {
  for_each = toset([ "sa-east-1a", "sa-east-1b" ])
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}


output "output_v2_1" {
 #value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
 value = toset([
      for t in data.aws_ec2_instance_type_offerings.my_ins_type2 : t.instance_types
    ])  
}

output "output_v2_2" {
 value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2 :
  az => details.instance_types }   
}
```
![image](https://github.com/user-attachments/assets/c29b5934-49ac-495e-bdbb-365f4500bb68)

## File c2-v3-get-instancetype-supported-per-az-in-a-region.tf
- Get List of Availability Zones in a Specific Region
```
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
```

- Update for_each with new datasource.
```
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.my_azones.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}
```

- Implement Incremental Outputs till we reach what is required
```
# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_v3_1" {
 value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types }   
}

# Filtered Output: Exclude Unsupported Availability Zones
output "output_v3_2" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 }
}

# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v3_3" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 }) 
}

# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3_4" {
  value = keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 })[0]
}
```
![image](https://github.com/user-attachments/assets/b8f82e61-5b3d-47ab-a3b3-fcd6d787ecc8)
