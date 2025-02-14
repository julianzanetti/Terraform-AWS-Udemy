# EC2 Instance
resource "aws_instance" "mi_ec2" {
    ami = data.aws_ami.amzlinux2.id
    #instance_type = var.tipo_instancia
    instance_type = var.tipo_instancia_lista[1]                  # Seleccionamos la t2.micro de la lista de instancias
    #instance_type = var.tipo_instancia_map["prod"]          # Seleccionamos la t2.larges de nuestro diccionario de instancias         
    user_data = file("${path.module}/app1-install.sh")
    key_name = var.ec2-keypair
    subnet_id = "subnet-0f8cb5e5d25489f1d"
    vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
    count = 2
    tags = {
        "Name" = "EC2 Demo-${count.index}"
    }
}