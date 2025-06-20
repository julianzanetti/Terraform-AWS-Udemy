module "public-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "Public-Security-Group"
  description = "Security Group with SSH port open for everyone (IPV4 CIDR)"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules:
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rules:
  egress_rules = ["all-all"]

  # Tags:
  tags = local.commom_tags
}