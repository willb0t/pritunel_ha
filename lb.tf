resource "aws_eip" "pritunl_nlb_eip" {}

resource "aws_lb" "pritunl_nlb" {
  name                             = "${var.name}-nlb"
  internal                         = false
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true

  subnet_mapping {
    subnet_id     = aws_subnet.public_subnet_1a.id
    allocation_id = aws_eip.pritunl_nlb_eip.id
  }
}

resource "aws_lb_target_group" "pritunl_tg_vpn" {
  name                   = "${var.name}-vpn-tg"
  port                   = 11111
  protocol               = "UDP"
  vpc_id                 = aws_vpc.pritunl.id
  deregistration_delay   = "60"
  connection_termination = true

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    port                = "80"
    protocol            = "TCP"
    unhealthy_threshold = 3
  }

}

#resource "aws_lb_target_group_attachment" "pritunl_tg_attachment_vpn" {
#  target_group_arn = aws_lb_target_group.pritunl_tg_vpn.arn
#  target_id        = aws_instance.pritunl_instance.id
#}

resource "aws_lb_listener" "pritunl_nlb_listener_vpn" {
  load_balancer_arn = aws_lb.pritunl_nlb.arn
  port              = var.pritunl_port
  protocol          = "UDP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pritunl_tg_vpn.arn
  }
}

#######################################################################################################################

# Create ALB
resource "aws_lb" "pritunl_alb" {
  name                             = "${var.name}-alb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.pritunl_alb_sg.id]
  enable_cross_zone_load_balancing = true
  subnets                          = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id,
    aws_subnet.public_subnet_1c.id,
    aws_subnet.public_subnet_1d.id
  ]
}

# Create ALB HTTP target group
resource "aws_lb_target_group" "alb_tg_http" {
  name     = "${var.name}-alb-http-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.pritunl.id

  health_check {
    matcher = "200,301,302"
  }
}

# Create ALB HTTPS target group
resource "aws_lb_target_group" "alb_tg_https" {
  name     = "${var.name}-alb-https-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.pritunl.id

  health_check {
    matcher = "200,301,302"
  }
}

# Create ALB HTTP Listener
resource "aws_lb_listener" "pritunl_alb_listener_http" {
  load_balancer_arn = aws_lb.pritunl_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_http.arn
  }
}

# Create ALB HTTPS Listener
resource "aws_lb_listener" "pritunl_alb_listener_https" {
  load_balancer_arn = aws_lb.pritunl_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.pritunl_cert_validation.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_https.arn
  }
}

# Attach EC2 Instance to ALB HTTP TG
#resource "aws_lb_target_group_attachment" "alb_tg_http_attachment" {
#  target_group_arn = aws_lb_target_group.alb_tg_http.arn
#  target_id        = aws_instance.pritunl_instance.id
#}

# Attach EC2 Instance to ALB HTTPS TG
#resource "aws_lb_target_group_attachment" "alb_tg_https_attachment" {
#  target_group_arn = aws_lb_target_group.alb_tg_https.arn
#  target_id        = aws_instance.pritunl_instance.id
#}

# Create NLB HTTP target group that forwards traffic to alb
resource "aws_lb_target_group" "nlb_tg_http" {
  name        = "${var.name}-nlb-http-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.pritunl.id
  target_type = "alb"
}

# Create target group attachment
resource "aws_lb_target_group_attachment" "nlb_http_tg_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg_http.arn
  target_id        = aws_lb.pritunl_alb.arn
  port             = 80
}

# Create NLB HTTPS target group that forwards traffic to alb
resource "aws_lb_target_group" "nlb_tg_https" {
  name        = "${var.name}-nlb-https-tg"
  port        = 443
  protocol    = "TCP"
  vpc_id      = aws_vpc.pritunl.id
  target_type = "alb"
}

# Create target group attachment
resource "aws_lb_target_group_attachment" "nlb_https_tg_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg_https.arn
  target_id        = aws_lb.pritunl_alb.arn
  port             = 80
}

