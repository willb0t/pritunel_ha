# Miscellaneous
variable "canonical_account_id" {
  type        = string
  description = "Account ID of Canonical"
}

variable "environment" {
  type        = string
  description = "Environment in which the stack resides"
}

variable "name" {
  description = "pritunl-ha-test"
  type        = string
  default     = "pritunl-ha-test"
}

variable "instance_type" {
  description = "instance type for asg"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "(optional)"
  type        = map(string)
  default     = null
}

variable "pritunl_port" {
  description = "Port used by Pritunl"
  type        = string
}

# VPC Variables
variable "aws_region" {
  type        = string
  description = "AWS Region"

}
variable "public_subnet_1a" {
  type = string
}

variable "public_subnet_1b" {
  type = string
}

variable "public_subnet_1c" {
  type = string
}

variable "public_subnet_1d" {
  type = string
}

variable "private_subnet_1a" {
  type = string
}

variable "private_subnet_1b" {
  type = string
}

variable "private_subnet_1c" {
  type = string
}

variable "private_subnet_1d" {
  type = string
}

variable "cidr_block" {
  description = "(required)"
  type        = string
}

variable "pritunl_ami_id" {
  description = "pritunl set image"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "domain name of the UI endpoint"
}

variable "hosted_zone_domain" {
  type        = string
  description = "Hosted Zone FQDN"
}
