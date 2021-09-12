provider "aws" {
  region  = "us-west-2"
  profile = var.aws_profile
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "brick-house"
    workspaces {
      prefix = "rearc-quest-infra-"
    }
  }
}

data "aws_region" "current" {}

# data "aws_eks_cluster" "default" {
#   name = "default"
# }

# data "aws_eks_cluster_auth" "default" {
#   name = "default"
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.default.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.default.token
#   load_config_file       = false
# }