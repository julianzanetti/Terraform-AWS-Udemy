module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name    = "alb-application"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
}