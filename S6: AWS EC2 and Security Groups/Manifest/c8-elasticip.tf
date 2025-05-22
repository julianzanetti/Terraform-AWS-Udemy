resource "aws_eip" "public_elastic_ip" {
  depends_on = [ module.public_ec2_instance, module.vpc ]
  instance = module.public_ec2_instance.id
  domain   = "vpc"
  tags = local.commom_tags
}