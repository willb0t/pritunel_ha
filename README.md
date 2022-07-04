Pritunl OpenVPN in High Availability Mode

> **This setup requires MongDB Atlas. Configuration of MongoDB is done separately and is not included in this tutorial.**

This setup will create AWS resources as mentioned in the table below.

## Requirements

* MongoDB Atlas (Shared/Dedicated)

## Providers

| Name                                              | Version |
|---------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.21.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                               | Type        |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_acm_certificate.pritunl_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                    | resource    |
| [aws_acm_certificate_validation.pritunl_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation)   | resource    |
| [aws_autoscaling_group.pritunl_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)                                 | resource    |
| [aws_eip.pritunl_nlb_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                                         | resource    |
| [aws_iam_instance_profile.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)                               | resource    |
| [aws_iam_role.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                       | resource    |
| [aws_instance.pritunl_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                              | resource    |
| [aws_internet_gateway.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)                                       | resource    |
| [aws_key_pair.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)                                                       | resource    |
| [aws_launch_template.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)                                         | resource    |
| [aws_lb.pritunl_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)                                                               | resource    |
| [aws_lb.pritunl_nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)                                                               | resource    |
| [aws_lb_listener.pritunl_alb_listener_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)                               | resource    |
| [aws_lb_listener.pritunl_alb_listener_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)                              | resource    |
| [aws_lb_listener.pritunl_nlb_listener_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)                                | resource    |
| [aws_lb_target_group.alb_tg_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                                     | resource    |
| [aws_lb_target_group.alb_tg_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                                    | resource    |
| [aws_lb_target_group.nlb_tg_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                                     | resource    |
| [aws_lb_target_group.nlb_tg_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                                    | resource    |
| [aws_lb_target_group.pritunl_tg_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                                  | resource    |
| [aws_lb_target_group_attachment.alb_tg_http_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)    | resource    |
| [aws_lb_target_group_attachment.alb_tg_https_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)   | resource    |
| [aws_lb_target_group_attachment.nlb_http_tg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)    | resource    |
| [aws_lb_target_group_attachment.nlb_https_tg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)   | resource    |
| [aws_lb_target_group_attachment.pritunl_tg_attachment_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource    |
| [aws_route.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                                             | resource    |
| [aws_route53_record.pritunl_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                       | resource    |
| [aws_route53_record.pritunl_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                  | resource    |
| [aws_route_table.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                                                 | resource    |
| [aws_route_table_association.subnet_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                       | resource    |
| [aws_route_table_association.subnet_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                       | resource    |
| [aws_route_table_association.subnet_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                       | resource    |
| [aws_route_table_association.subnet_1d](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)                       | resource    |
| [aws_security_group.pritunl_alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                    | resource    |
| [aws_security_group.pritunl_ec2_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                    | resource    |
| [aws_subnet.subnet_1a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                         | resource    |
| [aws_subnet.subnet_1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                         | resource    |
| [aws_subnet.subnet_1c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                         | resource    |
| [aws_subnet.subnet_1d](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                                         | resource    |
| [aws_vpc.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                                                 | resource    |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                                               | data source |
| [aws_caller_identity.id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                           | data source |
| [aws_iam_policy_document.pritunl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                              | data source |
| [aws_route53_zone.pritunl_dns_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                                   | data source |
| [aws_route53_zone.pritunl_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                                   | data source |

## Inputs

| Name                                                                                               | Description                            | Type          | Default                    | Required |
|----------------------------------------------------------------------------------------------------|----------------------------------------|---------------|----------------------------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)                                 | AWS Region                             | `string`      | n/a                        |   yes    |
| <a name="input_canonical_account_id"></a> [canonical\_account\_id](#input\_canonical\_account\_id) | Account ID of Canonical                | `string`      | n/a                        |   yes    |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block)                                 | (required)                             | `string`      | n/a                        |   yes    |
| <a name="input_environment"></a> [environment](#input\_environment)                                | Environment in which the stack resides | `string`      | n/a                        |   yes    |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type)                        | instance type for asg                  | `string`      | `"t2.micro"`               |    no    |
| <a name="input_name"></a> [name](#input\_name)                                                     | cldcvr-pritunl-ha-test                 | `string`      | `"cldcvr-pritunl-ha-test"` |    no    |
| <a name="input_pritunl_ami_id"></a> [pritunl\_ami\_id](#input\_pritunl\_ami\_id)                   | pritunl set image                      | `string`      | n/a                        |   yes    |
| <a name="input_pritunl_port"></a> [pritunl\_port](#input\_pritunl\_port)                           | Port used by Pritunl                   | `string`      | n/a                        |   yes    |
| <a name="input_subnet_1a"></a> [subnet\_1a](#input\_subnet\_1a)                                    | n/a                                    | `string`      | n/a                        |   yes    |
| <a name="input_subnet_1b"></a> [subnet\_1b](#input\_subnet\_1b)                                    | n/a                                    | `string`      | n/a                        |   yes    |
| <a name="input_subnet_1c"></a> [subnet\_1c](#input\_subnet\_1c)                                    | n/a                                    | `string`      | n/a                        |   yes    |
| <a name="input_subnet_1d"></a> [subnet\_1d](#input\_subnet\_1d)                                    | n/a                                    | `string`      | n/a                        |   yes    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                     | (optional)                             | `map(string)` | `null`                     |    no    |

## Outputs

| Name                                                                            | Description |
|---------------------------------------------------------------------------------|-------------|
| <a name="output_dns_endpoint"></a> [dns\_endpoint](#output\_dns\_endpoint)      | n/a         |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | n/a         |
| <a name="output_nlb_eip"></a> [nlb\_eip](#output\_nlb\_eip)                     | n/a         |
