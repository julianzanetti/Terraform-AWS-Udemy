# Create EC2 Instances and Security Groups with Input/Output Variables.
## Pre-requisite Note
- Create a `terraform-key` in AWS EC2 Key pairs which we will reference in our EC2 Instance.

## Define Input Variables in Terraform, File c2-variables.tf
- [Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
- [Terraform Input Variable Usage - 10 different types](https://github.com/stacksimplify/hashicorp-certified-terraform-associate/tree/main/05-Terraform-Variables/05-01-Terraform-Input-Variables)

```
# Input Variables
# AWS Region
variable "aws_region" {
    description = "Region en el cual los Recursos de AWS seran creados" #Descripcion
    type = string                                                       #Tipo de variable
    default = "sa-east-1"                                               #Parametro por defecto de la variable    
}

# AWS EC2 Instance Type
variable "tipo_instancia" {
    description = "Tipo de instancias EC2"
    type = string
    default = "t2.micro"
}

# AWS EC2 Instance Key-pair
variable "ec2-keypair" {
    description = "Par de claves para nuestra instancia EC2"
    type = string
    default = "terraform-key"
}
```
- Reference the variables in respective .tf files
```
# c1-versions.tf
region  = var.aws_region
```
![image](https://github.com/user-attachments/assets/7eec6b7f-9a69-4c0e-8ce3-342c13e8dd79)

```
# c5-ec2instance.tf
instance_type = var.tipo_instancia
key_name = var.ec2-keypair  
```
![image](https://github.com/user-attachments/assets/235d9f22-da0b-43a5-aa47-71860687ed99)

## Define Security Group Resources in Terraform, Files c3-ec2securitygroups.tf
