# Applying the solution of the previous topic.
## Edit the file c5-ec2instances.tf
```
# Availability Zones Datasource
data "aws_availability_zones" "my_AWSAZ" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Get InstanceType supported per AZ in a region
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.my_AWSAZ.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
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
    for_each = toset(keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type : az => details.instance_types if length(details.instance_types) != 0 }))
    availability_zone = each.key # Tambien puedes usar each.value porque en las listas each.key == each.values
    tags = {
        "Name" = "For-Each-Demo-${each.key}"
    }
}
```

## Execute Terraform command.
```
terraform plan
```
![image](https://github.com/user-attachments/assets/7c600b01-7463-4dbe-99f0-23bf30ec17e0)

```
terraform apply -auto-approve
```
![image](https://github.com/user-attachments/assets/5fb89b86-9281-4f6e-8b41-fa0f6d119335)

```
terraform destroy -auto-approve
```
