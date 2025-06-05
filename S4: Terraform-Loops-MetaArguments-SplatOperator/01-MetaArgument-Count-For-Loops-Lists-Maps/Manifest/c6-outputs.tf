# Terraform Output Values
# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instancia in aws_instance.mi_ec2: instancia.public_dns]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instancia in aws_instance.mi_ec2: instancia.id => instancia.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instancia in aws_instance.mi_ec2: c => instancia.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.mi_ec2.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.mi_ec2[*].public_dns
}