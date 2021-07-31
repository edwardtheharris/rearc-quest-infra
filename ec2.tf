data "aws_ami" "amazon" {
  most_recent = true
  owners = "766535289950"

  filter {
    name   = "name"
    values = ["amazonlinux-2-base_*"]
  }
}

resource "aws_instance" "rearc" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t3.micro"

  tags = {
    Name = "Rearc Quest"
  }
}