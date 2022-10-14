name                 = "pritunl-ha"
environment          = "poc"
aws_region           = "us-east-1"
cidr_block           = "172.16.16.0/24"
public_subnet_1a     = "172.16.16.0/27"
public_subnet_1b     = "172.16.16.32/27"
public_subnet_1c     = "172.16.16.64/27"
public_subnet_1d     = "172.16.16.96/27"
private_subnet_1a    = "172.16.16.128/27"
private_subnet_1b    = "172.16.16.160/27"
private_subnet_1c    = "172.16.16.192/27"
private_subnet_1d    = "172.16.16.224/27"
canonical_account_id = "114738012610"
instance_type        = "t2.micro"
pritunl_port         = "11111"
pritunl_ami_id       = "ami-0149b2da6ceec4bb0"
domain_name          = "pritunl-ha.zeroshell.sh"
hosted_zone_domain   = "zeroshell.sh"