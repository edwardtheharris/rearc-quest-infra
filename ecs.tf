resource "aws_ecs_cluster" "default" {
  name = "default"
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
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rearc.key_name
  subnet_id     = data.aws_subnet.us-west-2a
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
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rearc.key_name
  subnet_id     = data.aws_subnet.us-west-2bt
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
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rearc.key_name
  subnet_id     = data.aws_subnet.us-west-2c
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
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rearc.key_name
  subnet_id     = data.aws_subnet.us-west-2d
  tags = {
    Name = "Rearc Quest ecs us-west-2d"
  }
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
}