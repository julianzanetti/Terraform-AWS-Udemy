# Create AWS VPC + EC2 Instances + Security Groups with Terraform.
## The infrastructure:
![image](https://github.com/user-attachments/assets/9f957dba-1ef3-4b18-b366-ec62b118fc28)

## Terraform Modules we will use:
- [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [terraform-aws-modules/security-group/aws](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
- [terraform-aws-modules/ec2-instance/aws](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)

## Terraform new concepts I learned:
- [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
- [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)
- [file provisioner](https://www.terraform.io/docs/language/resources/provisioners/file.html)
- [remote-exec provisioner](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html)
- [local-exec provisioner](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html)
- [depends_on Meta-Argument](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

## What are we going implement?
- Create VPC with 3-Tier Architecture (Web, App and DB).
- Create AWS Security Group Terraform Module and define HTTP port 80, 22 inbound rule for entire internet access `0.0.0.0/0`.
- Create Multiple EC2 Instances in VPC Private Subnets and install. 
- Create EC2 Instance in VPC Public Subnet `Bastion Host`.
- Create Elastic IP for `Bastion Host` EC2 Instance.
- Create `null_resource` with following 3 Terraform Provisioners:
  - File Provisioner
  - Remote-exec Provisioner
  - Local-exec Provisioner

## Pre-requisite
- Copy your AWS EC2 Key pair in `private-key` folder. (Try to call it the same as `terraform-key.pem`).
- Create folder witht name `local-exec-output-files` where `local-exec` provisioner creates a file.

## Step 01: Create all the VPC config:
- c1-versions.tf
- c2-genericvariables.tf
- c3-local-values.tf
- c4-01-vpc-variables.tf
- c4-02-vpc-module.tf
- c4-03-vpc-outputs.tf
- private-key/terraform-key.pem

## Step 02: Add app-install.sh
- Add `app1-install.sh` in working directory

## Step-03: Create Security Groups for Bastion Host and Private Subnet Hosts.
- c5-01-securitygroup-public.tf
- c5-02-securitygroup-private.tf
- c5-03-securitygroup-outputs.tf

## Step-04: Get the latest AMI ID for Amazon Linux2 OS
- c6-datasource-ami.tf

## Step-05: EC2 Instances:
- c7-01-ec2instances-variables.tf
- c7-02-ec2instances-public.tf
- c7-03-ec2instances-private.tf
- c7-04-ec2instances-outputs.tf

## Step-06: Create Elastic Ip for Bastion Host.
- c8-elasticip.tf

## Step-07: Create a Null Resource and Provisioners
- Modify c1-versions.tf and add:
```
null = {
  source = "hashicorp/null"
  version = "~> 3.0.0"
}   
```
- c9-nullresources-provisioners.tf

## Step-08: Execute Terraform commands
```
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
Observation: 
1) Review Security Group resources 
2) Review EC2 Instance resources
3) Review all other resources (vpc, elasticip) 

# Terraform Apply
terraform apply -auto-approve
Observation:
1) VERY IMPORTANT: Primarily observe that first VPC NAT Gateway will be created and after that only module.ec2_private related EC2 Instance will be created
```
