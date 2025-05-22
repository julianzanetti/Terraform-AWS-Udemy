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

## Step 01 - Create all the VPC config:
