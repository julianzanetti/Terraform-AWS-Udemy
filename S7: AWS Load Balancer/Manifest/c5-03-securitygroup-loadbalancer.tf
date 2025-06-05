module "loadbalancer-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "LoadBalancer-Security-Group"
  description = "Security group with HTTP open for everyone (IPV4 CIDR)"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules:
  ingress_rules = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rules:
  egress_rules = ["all-all"]

  # Tags:
  tags = local.commom_tags
}