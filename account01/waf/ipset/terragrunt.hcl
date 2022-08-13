include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//ipset"
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("ip-sets.yaml")))
}

inputs = {
  policies = local.env_vars.policies

  name               = local.env_vars.policies[*].name
  description        = local.env_vars.policies[*].description
  scope              = local.env_vars.policies[*].scope
  ip_address_version = local.env_vars.policies[*].ip_address_version
  addresses          = local.env_vars.policies[*].addresses

  tags = local.env_vars.policies[*].tags
}
