module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "VPC-Terraform"
  cidr = "10.0.0.0/16"
  azs             = ["sa-east-1a", "sa-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database subnets
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"]

  # NAT Gateways
  enable_nat_gateway = true
  single_nat_gateway = true

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
  
  tags = {
    Owner = "Julian"
    Enviroment = "Prueba"
  }
}
