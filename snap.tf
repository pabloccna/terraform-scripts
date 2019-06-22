provider "aws" {
	region = "us-east-1"
	access_key = "AKIAT4QTEZYAIX6OY5VR"
	secret_key = "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"
}
#########################
# OUTPUT VAR
#########################

output "snap" {
	description = "La IP pri de..."
 	value = "${aws_ebs_snapshot.example_snapshot.volume_id}"
}

# Snapshot
resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = "vol-0eccd5241de6d858e"

  tags = {
    Name = "*TF*-Snap-AR-Terra-Volumen"
  }
}
