data "aws_ami" "amazon" {
  most_recent = true
  owners = ["766535289950"]

  filter {
    name   = "name"
    values = ["amazonlinux-2-base_*"]
  }
}

resource "aws_key_pair" "rearc" {
  key_name   = "rearc"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "rearc" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.rearc.key_name
  user_data = file("ec2/user-data.sh")

  tags = {
    Name = "Rearc Quest"
  }
}