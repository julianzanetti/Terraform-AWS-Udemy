# Create AWS VPC + EC2 Instances + Security Groups + Classic Load Balancer.
## The Infrastructure:
![image](https://github.com/user-attachments/assets/1949fa6d-0cab-49ce-90bd-7d2c7934c377)

## Introduction:
- Create AWS Security Group module for ELB CLB Load Balancer
- Create AWS ELB Classic Load Balancer Terraform Module
- Define Outputs for Load Balancer
- Access and test

## Terraform Modules we will use:
- [Terraform Module AWS ELB](https://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest)

## Step 01: Copy all templates from previous section
- Copy `Manifests` folder from `S6: AWS EC2 and Security Groups`

## Step 02: Create LoadBalancer Security Group.
- c5-03-securitygroup-loadbalancer.tf

## Step 03: Create all module AWS ELB Classic Load Balancer.
- c10-01-loadbalancer-variables.tf
- c10-02-loadbalancer.tf
- c10-03-loadbalancer-outputs.tf

## Step 04: Execute Terraform Commands.
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
![image](https://github.com/user-attachments/assets/816b4d2e-c0ca-4970-ac25-79c5b8facd34)

## Step 05: Review all created resources
### EC2 Instances
![image](https://github.com/user-attachments/assets/2ade4e40-9933-46ff-b21f-2691463f2208)

### Load Balancer SG
![image](https://github.com/user-attachments/assets/4fc34da8-2a6c-42b0-a7c4-54905d69cadf)

### Load Balancer Instances are healthy
![image](https://github.com/user-attachments/assets/598e1e1b-4030-4c21-a99a-66d4aa9eb237)

### App using Load Balancer DNS Name
![image](https://github.com/user-attachments/assets/2edb9bb0-d0ab-43ce-a18b-cc286a754e5f)
![image](https://github.com/user-attachments/assets/fe823eef-7efe-4013-a068-b5c15bb36a59)
![image](https://github.com/user-attachments/assets/1fd24157-d161-4e25-b2ce-8782bb4eb2cb)

### App with port 81 using Load Balancer DNS Name
![image](https://github.com/user-attachments/assets/1f22aba7-bf42-47eb-a454-7aafad274810)

## Step 05: Clean Up.
```
# Terraform Destroy
terraform destroy -auto-approve

# Delete files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
