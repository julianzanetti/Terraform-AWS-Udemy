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