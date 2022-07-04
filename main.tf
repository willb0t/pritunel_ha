data "aws_caller_identity" "id" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.canonical_account_id]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}