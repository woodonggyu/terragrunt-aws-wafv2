terraform {
  source = "../../../modules//ipset"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars     = yamldecode(file(find_in_parent_folders("ip-sets.yaml")))
  account_vars = yamldecode(file(find_in_parent_folders("account.yaml")))
}

generate "provider" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.account_vars.aws_region}"
  profile = "${local.account_vars.aws_profile}"
}
EOF
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
