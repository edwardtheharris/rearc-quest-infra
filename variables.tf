variable "aws_profile" {
  default = "default"
}

variable "gpg_key_filename" {
  default = "xandertheharris.gpg"
}

variable "eks_access_cidr" {
  default = "10.0.0.0/8"
}

variable "eks-lb" {
  default = "none"
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