# Terraform Output Values
# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = [for instance in aws_instance.mi_ec2: instance.public_ip]
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = toset([for instance in aws_instance.mi_ec2: instance.public_dns])
}

# EC2 Instance Public IP
output "instance_publicip2" {
  description = "EC2 Instance Public IP"
  value = {for az, instance in aws_instance.mi_ec2: az => instance.public_ip}
}

# EC2 Instance Public DNS with TOMAP
output "instance_publicdns_tomap" {
  description = "EC2 Instance Public IP with TOMAP"
  value = tomap({for az, instance in aws_instance.mi_ec2: az => instance.public_ip})
}