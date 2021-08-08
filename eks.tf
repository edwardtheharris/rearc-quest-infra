# resource "aws_eks_cluster" "default" {
#   name     = "default"
#   role_arn = aws_iam_role.eks.arn

#   version = "1.21"
#   vpc_config {
#     endpoint_private_access = true
#     security_group_ids = [
#       aws_security_group.allow-ec2.id
#     ]
#     subnet_ids = [
#       data.aws_subnet.us-west-2a.id,
#       data.aws_subnet.us-west-2b.id,
#       data.aws_subnet.us-west-2c.id,
#       data.aws_subnet.us-west-2d.id
#     ]
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
#   ]
# }

# resource "aws_eks_node_group" "us-west-2a" {
#   cluster_name    = aws_eks_cluster.default.name
#   node_group_name = "us-west-2a"
#   node_role_arn   = aws_iam_role.eksNodeRole.arn
#   subnet_ids      = [data.aws_subnet.us-west-2a.id]

#   remote_access {
#     ec2_ssh_key = aws_key_pair.rearc.key_name
#   }

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   tags = {
#     Name = "rearc-us-west-2a"
#   }

#   timeouts {
#     create = "10m"
#     delete = "10m"
#     update = "10m"
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_eks_cluster.default,
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# resource "aws_eks_node_group" "us-west-2b" {
#   cluster_name    = aws_eks_cluster.default.name
#   node_group_name = "us-west-2b"
#   node_role_arn   = aws_iam_role.eksNodeRole.arn
#   subnet_ids      = [data.aws_subnet.us-west-2b.id]

#   remote_access {
#     ec2_ssh_key = aws_key_pair.rearc.key_name
#   }

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   tags = {
#     Name = "rearc-us-west-2b"
#   }

#   timeouts {
#     create = "10m"
#     delete = "10m"
#     update = "10m"
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_eks_cluster.default,
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# resource "aws_eks_node_group" "us-west-2c" {
#   cluster_name    = aws_eks_cluster.default.name
#   node_group_name = "us-west-2c"
#   node_role_arn   = aws_iam_role.eksNodeRole.arn
#   subnet_ids      = [data.aws_subnet.us-west-2c.id]

#   remote_access {
#     ec2_ssh_key = aws_key_pair.rearc.key_name
#   }

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   tags = {
#     Name = "rearc-us-west-2c"
#   }

#   timeouts {
#     create = "10m"
#     delete = "10m"
#     update = "10m"
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_eks_cluster.default,
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# resource "aws_eks_node_group" "us-west-2d" {
#   cluster_name    = aws_eks_cluster.default.name
#   node_group_name = "us-west-2d"
#   node_role_arn   = aws_iam_role.eksNodeRole.arn
#   subnet_ids      = [data.aws_subnet.us-west-2d.id]

#   remote_access {
#     ec2_ssh_key = aws_key_pair.rearc.key_name
#   }

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   tags = {
#     Name = "rearc-us-west-2d"
#   }

#   timeouts {
#     create = "10m"
#     delete = "10m"
#     update = "10m"
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_eks_cluster.default,
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }
