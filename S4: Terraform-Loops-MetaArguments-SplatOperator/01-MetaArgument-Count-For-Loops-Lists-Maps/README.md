# Terraform For Loops, Lists, Maps and Count Meta-Argument.
## Example List and Maps - File c2-variables.tf.
```
# AWS EC2 Instance Type - List
variable "lista_tipo_instancias" {
  description = "Lista de tipos de Instancias EC2"
  type = list(string)
  default = ["t2.micro", "t2.small, t2.large"]
}

# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "Map EC2 Instnace Type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa"  = "t2.small"
    "prod" = "t2.large"
  }
}
```

## How to reference List or Map values - File c5-ec2instances.tf.
```
# List
instance_type = var.instance_type_list[1]

# Map
instance_type = var.instance_type_map["prod"]
```

## Meta-Argument Count - File c5-ec2instances.tf.
```
count = 2

# count.index
  tags = {
    "Name" = "EC2 Demo-${count.index}"
  }
```

## Outputs - File c6-outputs.tf.
- For loop with List
- For loop with Map
- For loop with Map Advanced

```
# Terraform Output Values
# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instancia in aws_instance.mi_ec2: instancia.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instancia in aws_instance.mi_ec2: instancia.id => instancia.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instancia in aws_instance.mi_ec2: c => instancia.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.mi_ec2.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.mi_ec2[*].public_dns
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
Observations: 
1) Two EC2 Instances (Count = 2) of a Resource myec2vm will be created
2) Count.index will start from 0 and end with 1 for VM Names
3) Review outputs in detail (for loop with list, maps, maps advanced, splat legacy and splat latest)
```
- ### Lists and Maps for instance_type
`instance_type = var.tipo_instancia_lista[1]`

![image](https://github.com/user-attachments/assets/20a4311f-ca6a-4775-926a-ddd761edc928)

`instance_type = var.tipo_instancia_map["prod"]`

![image](https://github.com/user-attachments/assets/f36d89e4-a237-499d-886b-63ee257b4ba2)

- ### Two EC2 Instances (Count = 2) of a Resource mi_ec2 will be created
![image](https://github.com/user-attachments/assets/1b995aa5-0da0-4af6-96a0-b05f4fcb727b)
![image](https://github.com/user-attachments/assets/633af9d8-1a21-4a81-8488-41d085ca8c41)
![image](https://github.com/user-attachments/assets/e998ac0f-cfc0-4e18-84c4-8b0cfd58c355)

- ### Review outputs in detail (for loop with list, maps, maps advanced, splat legacy and splat latest)
![image](https://github.com/user-attachments/assets/25041a43-e957-43af-b6f4-69b6f1b85358)
> [!NOTE]
> The difference between splat legacy and splat latest is that splast legacy was discontinued in previous versions.

## Clean-Up.
```
# Terraform Destroy
terraform destroy -auto-approve
```
![image](https://github.com/user-attachments/assets/b5d72857-c39b-46cf-9992-7a20089d76d9)
