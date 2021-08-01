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

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role" "eksNodeRole" {
  name               = "eksNodeRole"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eksNodeRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eksNodeRole.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eksNodeRole.name
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.default.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.default.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "eks-oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "AmazonEKSLoadBalancerControllerRole" {
  assume_role_policy = data.aws_iam_policy_document.eks-oidc.json
  name               = "AmazonEKSLoadBalancerControllerRole"
}

resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "AWS ALB Controller Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = file("iam/alb-controller-policy.json")
}

resource "aws_iam_role_policy_attachment" "eks-alb-controller" {
  role = aws_iam_role.AmazonEKSLoadBalancerControllerRole.name
  policy_arn = aws_iam_policy.AWSLoadBalancerControllerIAMPolicy.arn
}