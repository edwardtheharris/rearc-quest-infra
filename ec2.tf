# data "aws_ami" "amazon" {
#   most_recent = true
#   owners      = ["766535289950"]

#   filter {
#     name   = "name"
#     values = ["amazonlinux-2-base_*"]
#   }
# }

# resource "aws_key_pair" "rearc" {
#   key_name   = "rearc"
#   public_key = file("xandertheharris.pub")
# }

# resource "aws_security_group" "allow-ec2" {
#   name        = "allow-ec2"
#   description = "Allow EC2 traffic"
#   vpc_id      = data.aws_vpc.default.id

#   ingress {
#     description      = "All from everywhere"
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow-ec2"
#     "kubernetes.io/cluster/default" = "owned"
#   }
# }

# # resource "aws_instance" "rearc" {
# #   ami = data.aws_ami.amazon.id
# #   depends_on = [
# #     aws_key_pair.rearc,
# #     aws_security_group.allow-ec2
# #   ]
# #   instance_type = "t3.micro"
# #   key_name      = aws_key_pair.rearc.key_name


# #   tags = {
# #     Name = "Rearc Quest EC2"
# #   }
# #   user_data              = file("ec2/user-data.sh")
# #   vpc_security_group_ids = [aws_security_group.allow-ec2.id]
# # }


# data "aws_ami" "ecs" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-ecs-hvm*"]
#   }
# }

# resource "aws_instance" "ecs-2a" {
#   ami = data.aws_ami.ecs.id
#   depends_on = [
#     aws_key_pair.rearc,
#     aws_security_group.allow-ec2
#   ]
#   iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
#   instance_type        = "t3.micro"
#   key_name             = aws_key_pair.rearc.key_name
#   subnet_id            = data.aws_subnet.us-west-2a.id
#   tags = {
#     Name = "Rearc Quest ecs us-west-2a"
#   }
#   vpc_security_group_ids = [aws_security_group.allow-ec2.id]
# }

# resource "aws_instance" "ecs-2b" {
#   ami = data.aws_ami.ecs.id
#   depends_on = [
#     aws_key_pair.rearc,
#     aws_security_group.allow-ec2
#   ]
#   iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
#   instance_type        = "t3.micro"
#   key_name             = aws_key_pair.rearc.key_name
#   subnet_id            = data.aws_subnet.us-west-2b.id
#   tags = {
#     Name = "Rearc Quest ecs us-west-2b"
#   }
#   vpc_security_group_ids = [aws_security_group.allow-ec2.id]
# }

# resource "aws_instance" "ecs-2c" {
#   ami = data.aws_ami.ecs.id
#   depends_on = [
#     aws_key_pair.rearc,
#     aws_security_group.allow-ec2
#   ]
#   iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
#   instance_type        = "t3.micro"
#   key_name             = aws_key_pair.rearc.key_name
#   subnet_id            = data.aws_subnet.us-west-2c.id
#   tags = {
#     Name = "Rearc Quest ecs us-west-2c"
#   }
#   vpc_security_group_ids = [aws_security_group.allow-ec2.id]
# }

# resource "aws_instance" "ecs-2d" {
#   ami = data.aws_ami.ecs.id
#   depends_on = [
#     aws_key_pair.rearc,
#     aws_security_group.allow-ec2
#   ]
#   iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.name
#   instance_type        = "t3.micro"
#   key_name             = aws_key_pair.rearc.key_name
#   subnet_id            = data.aws_subnet.us-west-2d.id
#   tags = {
#     Name = "Rearc Quest ecs us-west-2d"
#   }
#   vpc_security_group_ids = [aws_security_group.allow-ec2.id]
# }

# resource "aws_lb" "rearc" {
#   name               = "rearc"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.allow-ec2.id]
#   subnets = [
#     data.aws_subnet.us-west-2a.id,
#     data.aws_subnet.us-west-2b.id,
#     data.aws_subnet.us-west-2c.id,
#     data.aws_subnet.us-west-2d.id
#   ]
# }

# resource "aws_lb_target_group" "rearc" {
#   name     = "rearc"
#   port     = 3000
#   protocol = "HTTP"
#   vpc_id   = data.aws_vpc.default.id
# }

# resource "aws_lb_listener" "rearc-redirect" {
#   load_balancer_arn = aws_lb.rearc.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# resource "aws_lb_listener" "rearc-ssl" {
#   load_balancer_arn = aws_lb.rearc.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.hamdance.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.rearc.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "ecs-2a" {
#   target_group_arn = aws_lb_target_group.rearc.arn
#   target_id        = aws_instance.ecs-2a.id
#   port             = 3000
# }

# resource "aws_lb_target_group_attachment" "ecs-2b" {
#   target_group_arn = aws_lb_target_group.rearc.arn
#   target_id        = aws_instance.ecs-2b.id
#   port             = 3000
# }

# resource "aws_lb_target_group_attachment" "ecs-2c" {
#   target_group_arn = aws_lb_target_group.rearc.arn
#   target_id        = aws_instance.ecs-2c.id
#   port             = 3000
# }

# resource "aws_lb_target_group_attachment" "ecs-2d" {
#   target_group_arn = aws_lb_target_group.rearc.arn
#   target_id        = aws_instance.ecs-2d.id
#   port             = 3000
# }

# # resource "aws_lb_target_group_attachment" "rearc" {
# #   target_group_arn = aws_lb_target_group.rearc.arn
# #   target_id        = aws_instance.rearc.id
# #   port             = 3000
# # }

# # data "aws_lb" "eks" {
# #   name = "rearc-ingress"
# # }