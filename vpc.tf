data "aws_vpc" "default" {
  id = "vpc-af3030d7"
}

data "aws_subnet" "us-west-2a" {
  id = "subnet-54970a2c"
}

data "aws_subnet" "us-west-2b" {
  id = "subnet-c717a88d"
}

data "aws_subnet" "us-west-2c" {
  id = "subnet-8e98f4d3"
}

data "aws_subnet" "us-west-2d" {
  id = "subnet-d316f2f9"
}