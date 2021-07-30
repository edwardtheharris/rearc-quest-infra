provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "brick-house"

    workspaces {
      name = "rearc-quest-infra"
    }
  }
}