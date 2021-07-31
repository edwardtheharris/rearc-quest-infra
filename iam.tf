resource "aws_iam_user" "admin" {
  name = "xander"
  path = "/admins/"

  tags = {
    name = "Xander Harris"
  }
}

resource "aws_iam_user_login_profile" "admin" {
  user    = aws_iam_user.admin.name
  pgp_key = file(var.gpg_key_filename)
}

resource "aws_iam_user_policy_attachment" "admin-access" {
  user       = aws_iam_user.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  depends_on = [
    aws_iam_user.admin
  ]
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.admin.name
  encoding   = "SSH"
  public_key = file(var.public_key_path)
  depends_on = [
    aws_iam_user.admin
  ]
}

resource "aws_iam_access_key" "admin" {
  pgp_key = file(var.gpg_key_filename)
  user    = aws_iam_user.admin.name
  depends_on = [
    aws_iam_user.admin,
    aws_iam_user_policy_attachment.admin-access
  ]
}

# ECS

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "ecsInstanceRole" {
  name               = "ecsInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "container-service" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecsInstanceProfile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ecsInstanceRole.name
}

data "aws_iam_policy_document" "service-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "ecsServiceRole" {
  name               = "ecsServiceRole"
  assume_role_policy = data.aws_iam_policy_document.service-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-full-service" {
  role       = aws_iam_role.ecsServiceRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-task-exec" {
  role       = aws_iam_role.ecsServiceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# EKS

data "aws_iam_policy_document" "eks-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "eks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "eks" {
  name               = "eksClusterRole"
  assume_role_policy = data.aws_iam_policy_document.eks-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role" "eksNodeGroup" {
  name               = "eksNodeGroup"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eksNodeGroup.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eksNodeGroup.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eksNodeGroup.name
}
