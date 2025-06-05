# Create AWS VPC + EC2 Instances + Security Groups with Terraform.
## The infrastructure:
![image](https://github.com/user-attachments/assets/bbc9c9bb-83a7-402f-bc5d-eaa1d2e351ec)

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
- Add `app1-install.sh` in working directory.

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
![image](https://github.com/user-attachments/assets/7ecbfbbe-5a15-4b4e-8fe8-b9c4b6d89f44)

## Step-09: Review all created resources
### VPC:
![image](https://github.com/user-attachments/assets/ba6836dd-8e33-448a-ba6b-31e962d0ad7d)

### Security groups:
![image](https://github.com/user-attachments/assets/f9fb304b-238f-4683-9f59-b9ffd852b82a)

- **`Public`**:
![image](https://github.com/user-attachments/assets/bd4ecb0b-340a-4b51-a633-d0bff83e296a)

- **`Private`**:
![image](https://github.com/user-attachments/assets/f986ec79-5178-4eb9-a06d-b801543eb612)

### Subnets:
![image](https://github.com/user-attachments/assets/95936d82-6175-4b21-a8f5-0d573f594a82)

### EC2 Instance:
![image](https://github.com/user-attachments/assets/004b5eb0-e14f-444d-80f1-cf5827b00596)

### Elastic IP:
![image](https://github.com/user-attachments/assets/a663fbb5-9518-46db-8604-96817d55581e)

## Step-10: Connect to Bastion EC2 Instance and Test.
### Connect to Bastion EC2 Instance from local desktop.
```
ssh -i private-key/terraform-key.pem ec2-user@<PUBLIC_IP_FOR_BASTION_HOST>
```
![image](https://github.com/user-attachments/assets/fd176c35-7d8a-4d70-a6a2-84fd1ba638be)

### Curl Test for Bastion EC2 Instance to Private EC2 Instances.
```
curl  http://<Private-Instance-1-Private-IP>
curl  http://<Private-Instance-2-Private-IP>
```
![image](https://github.com/user-attachments/assets/92b59d84-abd0-40fc-a20c-af15622bcc3a)
![image](https://github.com/user-attachments/assets/d67daecc-f26b-4e93-a8b7-5abce9056514)


### Connect to Private EC2 Instances from Bastion EC2 Instance.
```
ssh -i /tmp/terraform-key.pem ec2-user@<Private-Instance-1-Private-IP>
cd /var/www/html
ls -la
```
![image](https://github.com/user-attachments/assets/db59cac0-cd26-4d41-8e22-12b10b31f7df)
![image](https://github.com/user-attachments/assets/b28edd1b-78e6-42cb-a977-f500d19c23cf)

### See the local-exec-output.
![image](https://github.com/user-attachments/assets/75cff5ff-3275-4c3e-9e1f-52a549aa60cc)

## Step-11: Clean up.
```
# Terraform Destroy
terraform destroy -auto-approve

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
```
