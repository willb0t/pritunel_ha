output "nlb_eip" {
  value = aws_eip.pritunl_nlb_eip.public_ip
}
#
#output "ec2_public_ip" {
#  value = aws_instance.pritunl_instance.public_ip
#}

output "dns_endpoint" {
  value = aws_route53_record.pritunl_endpoint.fqdn
}

output "nat_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "vpn_ip_1a" {
  value = aws_eip.pritunl_vpn_eip_1a.public_ip
}

output "vpn_ip_1b" {
  value = aws_eip.pritunl_vpn_eip_1b.public_ip
}

output "vpn_ip_1c" {
  value = aws_eip.pritunl_vpn_eip_1c.public_ip
}

output "vpn_ip_1d" {
  value = aws_eip.pritunl_vpn_eip_1d.public_ip
}