variable "instance_type" {
  description = "Type EC2 Instance"
  type = string
  default = "t2.micro"
}

variable "instace_key" {
  description = "EC2 Instance keypair"
  type = string
  default = "terraform-key"
}