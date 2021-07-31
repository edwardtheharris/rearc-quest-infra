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
    protocol         = "-1"
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
  ami = data.aws_ami.amazon.id
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rearc.key_name


  tags = {
    Name = "Rearc Quest EC2"
  }
  user_data              = file("ec2/user-data.sh")
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}


data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm*"]
  }
}

resource "aws_instance" "ecs-2a" {
  ami = data.aws_ami.ecs.id
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
  instance_type        = "t3.micro"
  key_name             = aws_key_pair.rearc.key_name
  subnet_id            = data.aws_subnet.us-west-2a.id
  tags = {
    Name = "Rearc Quest ecs us-west-2a"
  }
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}

resource "aws_instance" "ecs-2b" {
  ami = data.aws_ami.ecs.id
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
  instance_type        = "t3.micro"
  key_name             = aws_key_pair.rearc.key_name
  subnet_id            = data.aws_subnet.us-west-2b.id
  tags = {
    Name = "Rearc Quest ecs us-west-2b"
  }
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}

resource "aws_instance" "ecs-2c" {
  ami = data.aws_ami.ecs.id
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
  instance_type        = "t3.micro"
  key_name             = aws_key_pair.rearc.key_name
  subnet_id            = data.aws_subnet.us-west-2c.id
  tags = {
    Name = "Rearc Quest ecs us-west-2c"
  }
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}

resource "aws_instance" "ecs-2d" {
  ami = data.aws_ami.ecs.id
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
  instance_type        = "t3.micro"
  key_name             = aws_key_pair.rearc.key_name
  subnet_id            = data.aws_subnet.us-west-2d.id
  tags = {
    Name = "Rearc Quest ecs us-west-2d"
  }
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}