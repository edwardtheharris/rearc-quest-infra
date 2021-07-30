provider "aws" {
  region = "us-east-1"
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