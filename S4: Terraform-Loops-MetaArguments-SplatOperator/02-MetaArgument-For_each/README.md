# Terraform for_each Meta-Argument with Functions toset, tomap
## Introduction:
- [For_each MetaArgument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [toset Fuction](https://developer.hashicorp.com/terraform/language/functions/toset)
- [tomap Fuction](https://developer.hashicorp.com/terraform/language/functions/tomap)
- [Data Source AWS AZ](https://developer.hashicorp.com/terraform/language/data-sources)

## Data Source and for_each - File c5-ec2instances.tf
```
# Availability Zones Datasource
data "aws_availability_zones" "my_AWSAZ" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# EC2 Instance
resource "aws_instance" "mi_ec2" {
    ami = data.aws_ami.amzlinux2.id
    #instance_type = var.tipo_instancia
    instance_type = var.tipo_instancia_lista[1]                  # Seleccionamos la t2.micro de la lista de instancias
    #instance_type = var.tipo_instancia_map["prod"]          # Seleccionamos la t2.larges de nuestro diccionario de instancias         
    user_data = file("${path.module}/app1-install.sh")
    key_name = var.ec2-keypair
    vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
    # Creamos las instacias EC2 en todas las AZ de la VPC
    for_each = toset(data.aws_availability_zones.my_AWSAZ.names)
    # Tambien puedes usar each.value porque en las listas each.key == each.values
    tags = {
        "Name" = "For-Each-Demo-${each.key}"
    }
}
```

## Modify Outputs - File c6-outputs.tf
```
# Terraform Output Values
# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = [for instance in aws_instance.mi_ec2: instance.public_ip]
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = toset([for instance in aws_instance.mi_ec2: instance.public_dns])
}

# EC2 Instance Public IP
output "instance_publicip2" {
  description = "EC2 Instance Public IP"
  value = {for az, instance in aws_instance.mi_ec2: az => instance.public_ip}
}

# EC2 Instance Public DNS with TOMAP
output "instance_publicdns_tomap" {
  description = "EC2 Instance Public IP with TOMAP"
  value = tomap({for az, instance in aws_instance.mi_ec2: az => instance.public_ip})
}
```

## Execute Terraform Commands.
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
