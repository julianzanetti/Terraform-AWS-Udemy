# Terraform Output Values
# EC2 Instance Public IP
output "instancia_ippublica" {
    description = "IP publica de Instancia EC2"
    value = aws_instance.mi_ec2.public_ip
}

# EC2 Instance Public DNS
output "instancia_dnspublico" {
    description = "DNS publico de Instancia EC2"
    value = aws_instance.mi_ec2.public_dns
}