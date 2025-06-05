# Input Variables
# AWS Region
variable "aws_region" {
    description = "Region en el cual los Recursos de AWS seran creados" #Descripcion
    type = string                                                       #Tipo de variable
    default = "sa-east-1"                                               #Parametro por defecto de la variable    
}

# AWS EC2 Instance Type List
variable "tipo_instancia_lista" {
    description = "Lista del Tipo de instancias EC2"
    type = list(string)
    default = ["t2.nano", "t2.micro", "t2.small"]
}

# AWS EC2 Instance Type Map
variable "tipo_instancia_map" {
    description = "Tipo de Instancias EC2 mapeadas"
    type = map(string)
    default = {
      "dev" = "t2.nano"
      "qa" = "t2.micro"
      "prod" = "t2.small"
    } 
}

# AWS EC2 Instance Key-pair
variable "ec2-keypair" {
    description = "Par de claves para nuestra instancia EC2"
    type = string
    default = "terraform-key"
}