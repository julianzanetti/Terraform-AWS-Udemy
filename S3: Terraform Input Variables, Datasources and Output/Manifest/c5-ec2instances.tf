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