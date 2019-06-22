provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "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"
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

#########################
# EC2 + WebServer (cagardo desde user-data script)
#########################
# Crear una instancia ec2 de nombre 'AR-Terra'
# ubuntu AMI (free tier)			ami-c90195b0
# Amazon Linux AMI 2018.03.0 (free tier)	ami-0756fbca465a59a30
########################
resource "aws_instance" "example" {
	ami 		= "ami-0756fbca465a59a30"
	instance_type 	= "t2.micro"
	key_name	= "delgiudice.p"
	associate_public_ip_address = "true"
	user_data = "${file("3- Scripts/installweb.sh")}"
	vpc_security_group_ids  = ["sg-0aedba0a5671815a8","sg-03cc01e4a2bb2af5b","sg-00b4adcf035eb9cff"]
	
tags= {
	Name = "AR-Terra"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

volume_tags= {
	Name = "AR-Terra"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

}