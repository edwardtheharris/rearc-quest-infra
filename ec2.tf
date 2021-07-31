data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["766535289950"]

  filter {
    name   = "name"
    values = ["amazonlinux-2-base_*"]
  }
}

resource "aws_key_pair" "rearc" {
  key_name   = "rearc"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow-ec2" {
  name        = "allow-ec2"
  description = "Allow EC2 traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "All from everywhere"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-ec2"
  }
}


resource "aws_instance" "rearc" {
  ami            = data.aws_ami.amazon.id
  instance_type  = "t3.micro"
  key_name       = aws_key_pair.rearc.key_name
  security_groups = [aws_security_group.allow-ec2.id]
  user_data      = file("ec2/user-data.sh")

  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]

  tags = {
    Name = "Rearc Quest"
  }
}