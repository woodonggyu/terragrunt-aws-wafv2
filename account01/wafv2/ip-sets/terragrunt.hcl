terraform {
  source = "../../../modules//ipset"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  account_vars = yamldecode(file(find_in_parent_folders("account.yaml")))
  config_vars  = yamldecode(file("config.yaml"))
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

  name               = local.config_vars.policy[*].name
  description        = local.config_vars.policy[*].description
  scope              = local.config_vars.policy[*].scope
  ip_address_version = local.config_vars.policy[*].ip_address_version
  addresses          = local.config_vars.policy[*].addresses

  tags = local.env_vars.policies[*].tags
}
