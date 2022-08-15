terraform {
  source = "../../../modules//ipset"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "account" {
  path = find_in_parent_folders("account.hcl")
}

locals {
  config_vars = yamldecode(file("config.yaml"))
}

inputs = {
  policies = local.config_vars.policy

  name               = local.config_vars.policy[*].name
  description        = local.config_vars.policy[*].description
  scope              = local.config_vars.policy[*].scope
  ip_address_version = local.config_vars.policy[*].ip_address_version
  addresses          = local.config_vars.policy[*].addresses

  tags = local.config_vars.policy[*].tags
}
