variable "aws_profile" {
  default = "default"
}


variable "eks_access_cidr" {
  default = "10.0.0.0/8"
}

variable "eks-lb" {
  default = "none"
}

variable "gpg_key_filename" {
  default = "xandertheharris.gpg"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "secret_word" {
  default = "PhoenixProject"
}

variable "shared_credentials_file" {
  default = "~/.aws/credentials"
}

variable "subnet_a_cidr" {
  type = string
}

variable "subnet_b_cidr" {
  type = string
}

variable "subnet_c_cidr" {
  type = string
}

variable "subnet_d_cidr" {
  type = string
}

variable "vpc_cidr" {
  type = string
}