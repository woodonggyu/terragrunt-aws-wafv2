locals {
  aws_region  = "ap-northeast-2"
  aws_account_id = "test"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/[role_name]"
  }
}
EOF
}