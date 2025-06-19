module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # Database subnets
  create_database_subnet_group           = var.vpc_create_database_subnet_group
  create_database_subnet_route_table     = var.vpc_create_database_subnet_route_table
  database_subnets = var.vpc_database_subnets

  # NAT Gateways
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  # Tags
  ## Public Subnets
  public_subnet_tags = {
    Type = "public-subnets-terraform"
  }

  ## Private Subnets
  private_subnet_tags = {
    Type = "public-subnets-terraform"
  }

  ## Database Subnets
  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = local.commom_tags

}