# Create AWS VPC with NAT Gateway using Terraform.
## The infrastructure:
![image](https://github.com/user-attachments/assets/e4e85e5e-e1eb-4ad6-b214-ab2bc6692d76)

## Step 01: Introduction.
- Create VPC using `Terraform Modules`
- Define `Input Variables` for VPC module and reference them in VPC Terraform Module.
- Define `local values` and reference them in VPC Terraform Module.
- Define `Output Values` for VPC.

## Step 02: Create a VPC Module Terraform Configuration.
- c1-versions.tf
- c2-generic-variables.tf
- c3-localvalues.tf
- c4-01-vpc-variables.tf
- c4-02-vpc-module.tf
- c4-03-outputs.tf
- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

> [!NOTE]
> All the files are located inside the manifest folder.

## Step 03: Execute terraform commands.
```
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/75e559c8-2df2-449e-857e-58ad047fbfff)

## Step 04: Verify all resourses.
![image](https://github.com/user-attachments/assets/8c084dc3-f54c-43ef-b4f3-9fa14ee6d9a4)

## Step 05: Clean up.
```
terraform destroy -auto-approve
```
