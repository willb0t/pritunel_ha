resource "aws_route53_record" "pritunl_endpoint" {
  zone_id         = data.aws_route53_zone.pritunl_endpoint.zone_id
  name            = var.domain_name
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.pritunl_alb.dns_name
    zone_id                = aws_lb.pritunl_alb.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "pritunl_endpoint" {
  name = var.hosted_zone_domain
}
