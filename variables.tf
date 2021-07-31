variable "aws_profile" {
  default = "default"
}

variable "gpg_key_filename" {
  default = "xandertheharris.gpg"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "secret_word" {
  default = "wat"
}

variable "shared_credentials_file" {
  default = "~/.aws/credentials"
}