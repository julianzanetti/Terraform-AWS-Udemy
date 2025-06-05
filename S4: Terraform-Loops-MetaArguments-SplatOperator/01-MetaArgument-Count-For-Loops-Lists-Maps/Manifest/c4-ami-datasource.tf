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