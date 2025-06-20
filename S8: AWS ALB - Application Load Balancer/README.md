# Create AWS VPC + EC2 Instances + Security Groups + Classic Load Balancer.
## The Infrastructure:
![image](https://github.com/user-attachments/assets/1949fa6d-0cab-49ce-90bd-7d2c7934c377)

## Introduction:
- Create AWS ALB Application Load Balancer Terraform Module
- Define Outputs for Load Balancer
- Access and test

## Terraform Modules we will use:
- [Terraform Module AWS ELB](https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest)

## Step 01: Copy all templates from previous section
- Copy `Manifests` folder from `S6: AWS EC2 and Security Groups`
- Files from `c1 to c9`
 
## Step 02: Create all module AWS ALB Application Load Balancer.
- c10-01-applicationloadbalancer-variables.tf
- c10-02-applicationloadbalancer.tf
- c10-03-applicationloadbalancer-outputs.tf

## Step 03: Execute Terraform Commands.
```
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```

## Step 04: Review all created resources
### EC2 Instances


### Load Balancer SG


### Load Balancer Instances are healthy


### App using Load Balancer DNS Name


### App with port 81 using Load Balancer DNS Name

## Step 05: Clean Up.
```
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
