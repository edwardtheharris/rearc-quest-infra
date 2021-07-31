output "ecr_repository" {
  value = aws_ecr_repository.rearc-quest.repository_url
}

output "access_key_id" {
  value = aws_iam_access_key.admin.id
}

output "secret_access_key" {
  value = aws_iam_access_key.admin.encrypted_secret
}