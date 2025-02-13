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

## How to reference List or Map values.
```
# List
instance_type = var.instance_type_list[1]

# Map
instance_type = var.instance_type_map["prod"]
```

## Meta-Argument Count.
```
count = 2

# count.index
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
```
> [!NOTE]
> Count repeats the number of times we indicate the configured resource
