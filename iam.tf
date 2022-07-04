# IAM Role For EC2
data "aws_iam_policy_document" "pritunl" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "pritunl" {
  name                = "${var.name}-role"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.pritunl.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

resource "aws_iam_instance_profile" "pritunl" {
  name = "${var.name}-instance-profile"
  role = aws_iam_role.pritunl.name
}