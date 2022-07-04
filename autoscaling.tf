## AutoScaling Group that will host the pritunl
resource "aws_eip" "pritunl_vpn_eip_1a" {
  tags = {
    Name = "${var.name}-${var.aws_region}-1a-vpn-eip"
  }
}

resource "aws_eip" "pritunl_vpn_eip_1b" {
  tags = {
    Name = "${var.name}-${var.aws_region}-1b-vpn-eip"
  }
}

resource "aws_eip" "pritunl_vpn_eip_1c" {
  tags = {
    Name = "${var.name}-${var.aws_region}-1c-vpn-eip"
  }
}

resource "aws_eip" "pritunl_vpn_eip_1d" {
  tags = {
    Name = "${var.name}-${var.aws_region}-1d-vpn-eip"
  }
}

resource "aws_eip_association" "association_pritunl_vpn_eip_1a" {
  instance_id = data.aws_instance.pritunl_vpn_instances.id
  allocation_id = aws_eip.pritunl_vpn_eip_1a.id
}

resource "aws_network_interface" "pritunl_vpn_nic_1a" {
  subnet_id         = aws_subnet.public_subnet_1a.id
  security_groups   = [aws_security_group.pritunl_ec2_sg.id]
  source_dest_check = false
}

resource "aws_network_interface" "pritunl_vpn_nic_1b" {
  subnet_id         = aws_subnet.public_subnet_1b.id
  security_groups   = [aws_security_group.pritunl_ec2_sg.id]
  source_dest_check = false
}

resource "aws_network_interface" "pritunl_vpn_nic_1c" {
  subnet_id         = aws_subnet.public_subnet_1c.id
  security_groups   = [aws_security_group.pritunl_ec2_sg.id]
  source_dest_check = false
}

resource "aws_network_interface" "pritunl_vpn_nic_1d" {
  subnet_id         = aws_subnet.public_subnet_1d.id
  security_groups   = [aws_security_group.pritunl_ec2_sg.id]
  source_dest_check = false
}

resource "aws_eip_association" "pritunl_vpn_eip_associate_1a" {
  allocation_id        = aws_eip.pritunl_vpn_eip_1a.id
  network_interface_id = aws_network_interface.pritunl_vpn_nic_1a.id
}

resource "aws_eip_association" "pritunl_vpn_eip_associate_1b" {
  allocation_id        = aws_eip.pritunl_vpn_eip_1b.id
  network_interface_id = aws_network_interface.pritunl_vpn_nic_1b.id
}

resource "aws_eip_association" "pritunl_vpn_eip_associate_1c" {
  allocation_id        = aws_eip.pritunl_vpn_eip_1c.id
  network_interface_id = aws_network_interface.pritunl_vpn_nic_1c.id
}

resource "aws_eip_association" "pritunl_vpn_eip_associate_1d" {
  allocation_id        = aws_eip.pritunl_vpn_eip_1d.id
  network_interface_id = aws_network_interface.pritunl_vpn_nic_1d.id
}

resource "aws_launch_template" "pritunl_ui" {
  name                                 = "${var.name}-ui-launch-template"
  disable_api_termination              = false
  image_id                             = var.pritunl_ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  vpc_security_group_ids               = [aws_security_group.pritunl_ec2_sg.id]
  key_name                             = aws_key_pair.pritunl.key_name

  #  block_device_mappings {
  #    device_name = "/dev/sda1"
  #
  #    ebs {
  #      volume_size = 8
  #    }
  #  }

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.pritunl.name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }
}

resource "aws_launch_template" "pritunl_vpn" {
  name                                 = "${var.name}-vpn-launch-template"
  disable_api_termination              = false
  image_id                             = var.pritunl_ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = aws_key_pair.pritunl.key_name
  vpc_security_group_ids               = [aws_security_group.pritunl_ec2_sg.id]

#  network_interfaces {
#    network_interface_id = aws_network_interface.pritunl_vpn_nic_1a.id
#  }

  #  block_device_mappings {
  #    device_name = "/dev/sda1"
  #
  #    ebs {
  #      volume_size = 8
  #    }
  #  }

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.pritunl.name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }
}

#resource "aws_autoscaling_group" "pritunl_asg_ui" {
#  name                      = "${var.name}-ui-asg"
#  min_size                  = 1
#  max_size                  = 1
#  desired_capacity          = 1
#  health_check_grace_period = 120
#  default_cooldown          = 60
#  health_check_type         = "EC2"
#  vpc_zone_identifier = [
#    aws_subnet.private_subnet_1a.id,
#    aws_subnet.private_subnet_1b.id,
#    aws_subnet.private_subnet_1c.id,
#    aws_subnet.private_subnet_1d.id
#  ]
#
#  target_group_arns = [
#    aws_lb_target_group.alb_tg_https.arn,
#    aws_lb_target_group.alb_tg_http.arn
#  ]
#
#  launch_template {
#    id      = aws_launch_template.pritunl_ui.id
#    version = aws_launch_template.pritunl_ui.latest_version
#  }
#
#  tag {
#    key                 = "Name"
#    value               = "${var.name}-ui-asg"
#    propagate_at_launch = true
#  }
#
#  tag {
#    key                 = "Environment"
#    value               = var.environment
#    propagate_at_launch = true
#  }
#
#  timeouts {
#    delete = "15m"
#  }
#}
#
resource "aws_autoscaling_group" "pritunl_asg_vpn" {
  name                      = "${var.name}-vpn-asg"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 120
  default_cooldown          = 60
  health_check_type         = "EC2"

  vpc_zone_identifier = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id,
    aws_subnet.public_subnet_1c.id,
    aws_subnet.public_subnet_1d.id
  ]

  target_group_arns = [
    aws_lb_target_group.pritunl_tg_vpn.arn
  ]

  launch_template {
    id      = aws_launch_template.pritunl_vpn.id
    version = aws_launch_template.pritunl_vpn.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-vpn-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

