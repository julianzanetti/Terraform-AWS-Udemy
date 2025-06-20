module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name = "${var.environment}-Public-Instance"
  ami = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instace_key
  vpc_security_group_ids = [module.public-security-group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  tags = local.commom_tags
}