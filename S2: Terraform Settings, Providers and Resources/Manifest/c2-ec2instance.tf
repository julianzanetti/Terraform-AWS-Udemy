# Resource: EC2 Instance
resource "aws_instance" "mi_ec2" {
  ami = "ami-079a9eba298521f24"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}