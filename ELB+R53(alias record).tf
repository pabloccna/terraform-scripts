#########################
# Provider
#########################
provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "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"
}
#########################
# OUTPUT VAR
#########################
output "ELB-Dns-Name:" {
	description = "ELB-Dns-Name:"
 	value = "${aws_elb.elb.dns_name}"
}
output "ELB-register-i:" {
	description = "ELB-register-i:"
 	value = "${aws_elb.elb.instances}"
}
output "R53-zone:" {
	description = "R53-zone:"
 	value = "${aws_route53_record.www.zone_id}"
}
output "R53-hostname:" {
	description = "R53-hostname:"
 	value = "${aws_route53_record.www.alias}"
}
#########################
# 1 x ELB para testir y que genere el DNS name
#########################
resource "aws_elb" "elb" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
#########################
# 1 x R53, agrega alias record a un ELB auto.
#########################
resource "aws_route53_record" "www" {
  zone_id = "Z2YMMLQ2BF0RUF"
  name    = "test"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}
