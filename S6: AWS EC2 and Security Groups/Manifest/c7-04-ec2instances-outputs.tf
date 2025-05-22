# EC2 Public Instance
output "ec2_public_instance_id" {
  description = "The ID of the EC2 Public instance"
  value       = module.public_ec2_instance.id
}

output "ec2_public_instance_public_ip" {
  description = "The public IP address assigned to the EC2 Public instance."
  value       = module.public_ec2_instance.public_ip
}

# EC2 Private Instance
output "ec2_private_instance_id" {
  description = "The ID of the EC2 Private instance"
  #value       = module.private_ec2_instance.id
  value = [for ec2private in module.private_ec2_instance: ec2private.id]
}

output "ec2_private_instance_public_ip" {
  description = "The public IP address assigned to the EC2 Private instance."
  #value       = module.private_ec2_instance.public_ip
  value = [for ec2private in module.private_ec2_instance: ec2private.private_ip]
}
