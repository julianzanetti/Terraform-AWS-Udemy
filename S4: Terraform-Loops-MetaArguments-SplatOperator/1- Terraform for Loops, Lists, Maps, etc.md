# Terraform For Loops, Lists, Maps and Count Meta-Argument.
## Example List and Maps.
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
> [!NOTE]
> Example in the file c2-variables.tf

## How to reference List or Map values.
```
# List
instance_type = var.instance_type_list[1]

# Map
instance_type = var.instance_type_map["prod"]
```
> [!NOTE]
> Example in the file c5-ec2instances.tf

## Meta-Argument Count.
```
count = 2

# count.index
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
```
> [!NOTE]
> Count repeats the number of times we indicate the configured resource.
> Example in the file c5-ec2instances.tf

## Outputs.
- For loop with List
- For loop with Map
- For loop with Map Advanced

```
# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.myec2vm[*].public_dns
}
```
> [!NOTE]
> Example in the file c6-outputs.tf
