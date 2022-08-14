resource "aws_wafv2_ip_set" "this" {
  count = length(var.policies)

  name               = format("ipset-iac-%s", lower(var.name[count.index]))
  description        = var.description[count.index]
  scope              = var.scope[count.index]
  ip_address_version = var.ip_address_version[count.index]
  addresses          = var.addresses[count.index]

  tags = var.tags[count.index]
}