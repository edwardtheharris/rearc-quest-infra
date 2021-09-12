# output "ecr_repository" {
#   value = aws_ecr_repository.rearc-quest.repository_url
# }

# # output "endpoint" {
# #   value = aws_eks_cluster.default.endpoint
# # }
output "hello_world" {
  value = "Hello, World!"
}

# # output "kubeconfig-certificate-authority-data" {
# #   value = aws_eks_cluster.default.certificate_authority[0].data
# # }

# output "password" {
#   value = aws_iam_user_login_profile.admin.encrypted_password
# }

# output "access_key_id" {
#   value = aws_iam_access_key.admin.id
# }

# output "secret_access_key" {
#   value = aws_iam_access_key.admin.encrypted_secret
# }

output "subnet_a_id" {
  value = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  value = aws_subnet.subnet_b.id
}

output "subnet_c_id" {
  value = aws_subnet.subnet_c.id
}

output "subnet_d_id" {
  value = aws_subnet.subnet_d.id
}
output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "vpc_cidr" {
  value = data.aws_vpc.default.cidr_block
}