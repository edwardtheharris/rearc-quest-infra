data "aws_region" "current" {}

provider "aws" {
  region  = var.aws_region
}

output "hello_world" {
  value = "Hello, World!"
}

variable "aws_region" {}