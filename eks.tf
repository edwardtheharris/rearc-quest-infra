resource "aws_eks_cluster" "default" {
  name     = "default"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    security_group_ids = [
        aws_security_group.allow-ec2
    ]
    subnet_ids = [
      data.aws_subnet.us-west-2a.id,
      data.aws_subnet.us-west-2b.id,
      data.aws_subnet.us-west-2c.id,
      data.aws_subnet.us-west-2d.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "us-west-2a" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "us-west-2a"
  node_role_arn   = aws_iam_role.eksNodeGroup.arn
  subnet_ids = [data.aws_subnet.us-west-2a.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "us-west-2b" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "us-west-2b"
  node_role_arn   = aws_iam_role.eksNodeGroup.arn
  subnet_ids = [data.aws_subnet.us-west-2b.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "us-west-2c" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "us-west-2c"
  node_role_arn   = aws_iam_role.eksNodeGroup.arn
  subnet_ids = [data.aws_subnet.us-west-2c.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "us-west-2d" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "us-west-2d"
  node_role_arn   = aws_iam_role.eksNodeGroup.arn
  subnet_ids = [data.aws_subnet.us-west-2d.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
