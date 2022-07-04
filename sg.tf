resource "aws_security_group" "pritunl_ec2_sg" {
  name   = "${var.name}-ec2-sg"
  vpc_id = aws_vpc.pritunl.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PRITUNL"
    from_port   = 11111
    to_port     = 11111
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "local"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${aws_eip.pritunl_nlb_eip.public_ip}/32", var.cidr_block]
    security_groups = [aws_security_group.pritunl_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_security_group" "pritunl_alb_sg" {
  name   = "${var.name}-alb-sg"
  vpc_id = aws_vpc.pritunl.id

  ingress {
    description     = "internal"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.cidr_block]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-alb-sg"
  }
}