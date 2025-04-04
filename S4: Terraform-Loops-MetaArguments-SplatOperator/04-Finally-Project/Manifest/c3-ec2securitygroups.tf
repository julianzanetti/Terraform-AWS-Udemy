# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
    name        = "vpc-ssh"
    description = "Dev VPC SSH"
    vpc_id = "vpc-004d2726706107c87"

    ingress {
        description = "Habilitar puerto 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        description = "Habilitar todas las IP y puertos de salida"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
    name        = "vpc-web"
    description = "Dev VPC Web"
    vpc_id = "vpc-004d2726706107c87"

    ingress {
        description = "Habilitar puerto 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Habilitar puerto 443"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        description = "Habilitar todas las IP y puertos de salida"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
}