resource "aws_key_pair" "pritunl" {
  key_name   = var.name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCybZxb2IVqwHWjDJ44zpAbEinV7pbA92nFffMT5VSfMVBWdbOP+9r1w8rsVk+Um/RInoVjj4J9RuNLB3XBNe9oRsyX2KehknZnskEeYtOF11+CxTI0aVdGZYpWlOM2DlhPMatYk4MpwWN/sEt9akGOiLyFn5y/7VvwHLffruDOyWin4Knc7ia05gZiffTNQUOEKKaiJE/ShnGfVXro714eTZlobChGuvJn+3osIxvOoeZ4U0R7WkNlRMJkTCborJ4AFrhVgwZGEvVPhQqQ1c2z1BnHDoKWM2dtbVwYHcL4lb5uzxJFVtQLBCdNuW/2/lrqS8WcQRlIAACNzuaMtmL/LzTdhav3BK9J63sxaiw6zKCK/pHl52kJNGx2NP0Nrvd8SdQj+2BkrePZ/vgGZvvu5AoW56o2PE5LkugyDET9a1/lEq0dB+D6V53dQ7JsorNixjqwC0Rf1O2ubnXxizsMnQFTvsHBH1kazBAvqLN29tEm+izBT3ckkGrFn6tdpW4q9c4+ucYMR7YfwE5C3f2leES8Evv7c1Nc6xSdsx6iaO60F5thWYyrdu3iMrc2m9iXLy3K1QA4sJQRn3iPuZwRRUQFg73JeXPCYGaHW4vx5SwS19pTosdOv4i4Mjo5idM7n89N+38vw3l/Z3kjBuGEcEK5H8LTs0G8+JM43T/HuQ== vrnchndk@vrnchndk.local"
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
