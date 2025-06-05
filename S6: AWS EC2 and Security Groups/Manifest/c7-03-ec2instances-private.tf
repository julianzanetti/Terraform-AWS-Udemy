module "private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  depends_on = [module.vpc]
  for_each = toset(["1", "2"])
  name = "${var.environment}-PrivateInstance-${each.key}"
  ami = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instace_key
  user_data = file("${path.module}/app1-install.sh")
  vpc_security_group_ids = [module.private-security-group.security_group_id]
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))

  tags = local.commom_tags
}
