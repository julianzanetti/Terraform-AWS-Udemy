resource "null_resource" "aws_instance" {
  depends_on = [ module.public_ec2_instance ]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.public_elastic_ip.public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }
  
  # Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source ="private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  # Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [ "sudo chmod 400 /tmp/terraform-key.pem" ]
  }
  
  # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-outputs/"
  }  

/*
  # Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
  provisioner "local-exec" {
    command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-outputs/"
    when = destroy
    #on_failure = continue
  }
*/
}

