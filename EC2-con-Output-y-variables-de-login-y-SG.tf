provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

#########################
# OUTPUT VAR
#########################

output "ec2-id" {
	description = "EC2-Name:"
 	value = "${aws_instance.example.id}"
}
output "ec2-nombre" {
	description = "EC2-Name:"
 	value = "${aws_instance.example.tags.Name}"
}

output "public_ip" {
	description = "La IP pub de..."
 	value = "${aws_instance.example.public_ip}"
}
output "private_ip" {
	description = "La IP pri de..."
 	value = "${aws_instance.example.private_ip}"
}


# Crear una instancia ec2 de nombre 'example'
# ubuntu AMI (free tier)			ami-c90195b0
# Amazon Linux AMI 2018.03.0 (free tier)	ami-0756fbca465a59a30

resource "aws_instance" "example" {
	ami = "ami-0756fbca465a59a30"
	instance_type ="t2.micro"
	key_name	 = "delgiudice.p"
	vpc_security_group_ids  = ["sg-03cc01e4a2bb2af5b","sg-00b4adcf035eb9cff"] # PING y SSH
	
tags = {
	Name = "xxxxx"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

volume_tags= {
	Name = "xxx"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}
}


