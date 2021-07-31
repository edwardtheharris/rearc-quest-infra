provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = var.shared_credentials_file
  profile                 = var.aws_profile
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "brick-house"

    workspaces {
      name = "rearc-quest-infra"
    }
  }
}