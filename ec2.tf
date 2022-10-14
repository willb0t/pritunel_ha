resource "aws_key_pair" "pritunl" {
  key_name   = var.name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxDtqB0sUnepIAbU3nx/BaeDMw7xsNYJssOlxXs3Sjy5deloWr4NPGXx26etfYjMZued4U+fs7EvsEZYqbIe5RSGcwzltI7TjzBsXrK5aU13VRLADs+xZQh1mSuZfuVDR6ueULMMPzjPcM+njSlwuHoRQoBogg6QsvEXideXFd+A7w00A2HFdJ3SgOYH86TAl3h3MTGieNKB6bgIephMOlNUYHexaigs3z45fHfLyPhAmQZtTsikvegyn9vOzPoZ4b7xs1mKn87zvQ5DXDV9nDOKjJNtdKjxVmafbyxRI9Cdo4VVbobx/pByT2JNSiAThC1g5WW+oqM0/daQdPCRRJZxWiS0HaCPB1P3lRbwJ2K4IvX9uq63UdHFofRPVTNnepvwCdK/zpDJxbMFRpD9B1AKdPKReaM3dmK3sSKVyrLzZGP2xRuV6/g39aFkvt84EivzgNijhH6El59FSfS6a8mxIfdZdcqc/FGvBSIZ0GGg31qUFW+kj567HcV2HKk48= willb0t@boxbox"
}

data "aws_instance" "pritunl_vpn_instances" {
  filter {
    name   = "image-id"
    values = [var.pritunl_ami_id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name}-vpn-asg"]
  }
}


#resource "aws_instance" "pritunl_instance" {
#  ami                    = var.pritunl_ami_id
#  instance_type          = var.instance_type
#  iam_instance_profile   = aws_iam_instance_profile.pritunl.name
#  vpc_security_group_ids = [aws_security_group.pritunl_ec2_sg.id]
#  subnet_id              = aws_subnet.public_subnet_1a.id
#  key_name               = aws_key_pair.pritunl.key_name
#
#  tags = {
#    Name = var.name
#  }
#}
