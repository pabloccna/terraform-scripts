provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# Crear una instancia ec2 de nombre 'example'
# ubuntu AMI (free tier)			ami-c90195b0
# Amazon Linux AMI 2018.03.0 (free tier)	ami-0756fbca465a59a30

resource "aws_instance" "example" {
	ami		="ami-0756fbca465a59a30"
	instance_type 	="t2.micro"
	key_name	="delgiudice.p"

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
