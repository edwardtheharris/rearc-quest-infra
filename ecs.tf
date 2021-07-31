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
  ami                    = data.aws_ami.ecs.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.rearc.key_name
  vpc_security_group_ids = [aws_security_group.allow-ec2.id]
  depends_on = [
    aws_key_pair.rearc,
    aws_security_group.allow-ec2
  ]
  tags = {
    Name = "Rearc Quest ecs us-west-2a"
  }
}

resource "aws_instance" "ecs-2b" {

}

resource "aws_instance" "ecs-2c" {

}

resource "aws_instance" "ecs-2d" {

}