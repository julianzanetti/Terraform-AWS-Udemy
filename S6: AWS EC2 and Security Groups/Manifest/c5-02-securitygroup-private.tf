module "private-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "Private-Security-Group"
  description = "Security group with HTTP and SSH open for everyone (IPV4 CIDR)"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules:
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Egress Rules:
  egress_rules = ["all-all"]

  # Tags:
  tags = local.commom_tags
}