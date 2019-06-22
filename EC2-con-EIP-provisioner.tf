provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "RYzgZ4uzhvLdWN6ROVizQl4mPDi2BF26dBIbn6S5"
}
########################
# EIP
#########################
resource "aws_eip" "ip" {
	  instance = "${aws_instance.example.id}"
}

########################
# EC2
#########################
# Crear una instancia ec2 de nombre 'example'
# ubuntu AMI (free tier)			ami-c90195b0
# Amazon Linux AMI 2018.03.0 (free tier)	ami-0756fbca465a59a30

resource "aws_instance" "example" {
	ami 		= "ami-0756fbca465a59a30"
	instance_type 	= "t2.micro"
	key_name	= "delgiudice.p"

tags= {
	Name = "xxxxx"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

volume_tags= {
	Name = "xxxxx"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

#########################
# Provisioner
#########################
provisioner "local-exec" {
	command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
	
}

}
