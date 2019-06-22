provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "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"
}
#########################
# OUTPUT VAR #1 - Aca van los "atributos" que tiene el objeto para mostrar en pantalla
#########################
output "ec2-id" {
	description = "EC2-1-Name:"
 	value = "${aws_instance.example.id}"
}
output "ec2-nombre" {
	description = "EC2-1-Name:"
 	value = "${aws_instance.example.tags.Name}"
}
output "public_ip" {
	description = "EC2-1-IP-PUB:"
 	value = "${aws_instance.example.public_ip}"
}
output "private_ip" {
	description = "EC2-2-IP-PRI:"
 	value = "${aws_instance.example.private_ip}"
}
#########################
# OUTPUT VAR #2
#########################
output "ec2-id-2" {
	description = "EC2-2-Name:"
 	value = "${aws_instance.example-2.id}"
}
output "ec2-nombre-2" {
	description = "EC2-2-Name:"
 	value = "${aws_instance.example-2.tags.Name}"
}
output "public_ip-2" {
	description = "EC2-2-IP-PUB:"
 	value = "${aws_instance.example-2.public_ip}"
}
output "private_ip-2" {
	description = "EC2-2-IP-PUB:"
 	value = "${aws_instance.example-2.private_ip}"
}
#########################
# OUTPUT VAR #3 - Datos ELB
#########################
output "elb-id" {
	description = "Classic-ELB-Name:"
 	value = "${aws_elb.elb.id}"
}
output "elb-dns" {
	description = "Classic-ELB-DNS:"
 	value = "${aws_elb.elb.dns_name}"
}
output "elb-ins" {
	description = "Classic-ELB-registered:"
 	value = "${aws_elb.elb.instances}"
}

#########################
# Primera EC2 + WebServer (cagardo desde user-data script)
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
	user_data = "${file("3- Scripts/installweb-1.sh")}"
	vpc_security_group_ids  = ["sg-0aedba0a5671815a8","sg-03cc01e4a2bb2af5b","sg-00b4adcf035eb9cff"]
	iam_instance_profile = "Rol-Acceso-EC2-to-S3"
	
tags= {
	Name = "AR-Terra-wb-2"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

volume_tags= {
	Name = "AR-Terra-wb-2"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

}
#########################
# Segunda EC2 + WebServer (cagardo desde user-data script)
#########################
resource "aws_instance" "example-2" {
	ami 		= "ami-0756fbca465a59a30"
	instance_type 	= "t2.micro"
	key_name	= "delgiudice.p"
	associate_public_ip_address = "true"
	user_data = "${file("3- Scripts/installweb-2.sh")}"
	vpc_security_group_ids  = ["sg-0aedba0a5671815a8","sg-03cc01e4a2bb2af5b","sg-00b4adcf035eb9cff"]
	iam_instance_profile = "Rol-Acceso-EC2-to-S3"
	
tags= {
	Name = "AR-Terra-wb-2"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

volume_tags= {
	Name = "AR-Terra-wb-2"
	Ceco = "CSC95TEC"
	Owner = "Pablo Del Giudice"
	Grupo = "Infraestructura"
	}

}
#########################
# ELB + Group
#########################
resource "aws_elb" "elb" {
  name               = "elb-wb-server"
  availability_zones = ["us-east-1a", "us-east-1b"]
  cross_zone_load_balancing = true

#  access_logs {
#    bucket        = "foo"
#    bucket_prefix = "bar"
#    interval      = 60
#  }

listener {
	instance_port     = 80
	instance_protocol = "http"
	lb_port           = 80
	lb_protocol       = "http"
}
listener {
	instance_port      = 80
	instance_protocol  = "http"
	lb_port            = 80
	lb_protocol        = "http"
#	ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
}
health_check {
	interval            = 15
	timeout             = 3
	healthy_threshold   = 2
	unhealthy_threshold = 2
	target              = "HTTP:80/index.html"
}
	instances          	 = ["${aws_instance.example.id}","${aws_instance.example-2.id}"]
	cross_zone_load_balancing   = true
  	idle_timeout                = 400
  	connection_draining         = true
  	connection_draining_timeout = 400

tags = {
    Name = "terraform-elb"
}

}



