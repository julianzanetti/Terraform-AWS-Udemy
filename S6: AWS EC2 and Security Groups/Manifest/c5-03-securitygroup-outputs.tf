# Public EC2 Instances Security Group
# Public SG Id
output "public-security_group_id" {
  description = "The ID of the security group"
  value       = module.public-security-group.security_group_id
}

# VPC ID
output "pulic-security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public-security-group.security_group_vpc_id
}

# Public SG name
output "public-security_group_name" {
  description = "The name of the security group"
  value       = module.public-security-group.security_group_name
}

# Private EC2 Instances Security Group
# Private SG Id
output "private-security_group_id" {
  description = "The ID of the security group"
  value       = module.private-security-group.security_group_id
}

# VPC ID
output "private-security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private-security-group.security_group_vpc_id
}

# Private SG name
output "private-security_group_name" {
  description = "The name of the security group"
  value       = module.private-security-group.security_group_name
}