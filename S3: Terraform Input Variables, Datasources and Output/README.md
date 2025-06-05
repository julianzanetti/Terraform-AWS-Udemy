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
- [Resource: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

```
# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
    name        = "vpc-ssh"
    description = "Dev VPC SSH"
    vpc_id = "vpc-0f4fe08ceb8291ee0"

    ingress {
        description = "Habilitar puerto 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        description = "Habilitar todas las IP y puertos de salida"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
    name        = "vpc-web"
    description = "Dev VPC Web"
    vpc_id = "vpc-0f4fe08ceb8291ee0"

    ingress {
        description = "Habilitar puerto 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Habilitar puerto 443"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        description = "Habilitar todas las IP y puertos de salida"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- Reference the security groups in c5-ec2instances.tf file as a list item.
```
# List Item
vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ] 
```
![image](https://github.com/user-attachments/assets/c5ef0f6d-f9de-4960-9fb2-ef7d59e9db83)

## Define Get Latest AMI ID for Amazon Linux2 OS, File c4-ami-datasource.tf
- [Data Source: aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)

```
# Get Latest AWS AMI ID for Amazon2 Linux
data "aws_ami" "amzlinux2" {
  most_recent = true                            # Obtenemos la ultima version de la AMI que elegimos mas adelante
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-*-gp2" ]       # AMI ID seleccionado, este es el nombre de nuestra AMI
  }
  filter {
    name = "root-device-type"                   # Tipo de dispositivo raíz
    values = [ "ebs" ]  
  }
  filter {
    name = "virtualization-type"                # Virtualización
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
```
- Reference the datasource in c5-ec2instances.tf file.
```
# Reference Datasource to get the latest AMI ID
ami = data.aws_ami.amzlinux2.id
```
![image](https://github.com/user-attachments/assets/99e86297-14f9-4d63-9b36-6cc01acef635)

## Define EC2 Instance Resource, File c5-ec2instances.tf.
- [Resource: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
```
# EC2 Instance
resource "aws_instance" "mi_ec2" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = var.tipo_instancia
    user_data = file("${path.module}/app1-install.sh")
    key_name = var.ec2-keypair
    subnet_id = "subnet-0f8cb5e5d25489f1d"
    vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
    tags = {
        "Name" = "EC2 Demo"
    }
}
```

## Define Output Values, File c6-outputs.tf
- [Output Values](https://developer.hashicorp.com/terraform/language/values/outputs)

```
# Terraform Output Values
# EC2 Instance Public IP
output "instancia_ippublica" {
    description = "IP publica de Instancia EC2"
    value = aws_instance.mi_ec2.public_ip
}

# EC2 Instance Public DNS
output "instancia_dnspublico" {
    description = "DNS publico de Instancia EC2"
    value = aws_instance.mi_ec2.public_dns
}
```

## Execute Terraform Commands.
```
terraform init
```
![image](https://github.com/user-attachments/assets/9c428eda-5cd7-438c-8b1c-b9f2e29a6bd9)

```
terraform validate
```
![image](https://github.com/user-attachments/assets/b931a8aa-9400-4f37-baad-f1c413b12dce)

```
terraform plan
```
![image](https://github.com/user-attachments/assets/d320674a-f8d5-47cb-9e24-b76c2b843cc0)

```
terraform apply
```
![image](https://github.com/user-attachments/assets/2ab791e3-601f-404c-ab0a-026ac4dce503)

> [!NOTE]
> Let's see how we obtained the values of Output variables. 

## Check in the AWS Console.
- ### EC2 Instance
![image](https://github.com/user-attachments/assets/e7fab651-53c1-4516-b53f-f6d558678ed5)

- ### Segurity Groups.
![image](https://github.com/user-attachments/assets/9298db05-d3da-41ec-8965-9bc5018a4b70)

## Access Application.
```
# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html
```
![image](https://github.com/user-attachments/assets/5d2c8477-38c0-4774-b0e9-61dd9ee99cfe)
![image](https://github.com/user-attachments/assets/2022b9aa-7caa-44b1-ad1e-c019e12b75cf)

```
# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html
```
![image](https://github.com/user-attachments/assets/b49934cf-8c38-46c8-9e8c-0a5d42a04528)

## Access EC2 Instance with key-pair.
```
ssh -i terraform-key.pem ec2-user@IP-PUBLICA
```
![image](https://github.com/user-attachments/assets/c6953634-a40b-4dce-b085-7427202ab663)

## Clean-Up.
```
# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy
```
![image](https://github.com/user-attachments/assets/27ee843b-b554-4a3b-9bc3-09709aa7b02e)
![image](https://github.com/user-attachments/assets/729d9614-b2a8-424c-b392-f3a5dfbaf91f)

```
# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
![image](https://github.com/user-attachments/assets/5c53864b-058b-48a5-ba06-b14a22dbeb38)
