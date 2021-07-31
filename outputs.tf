output "access_key_id" {
    value = aws_iam_access_key.xander.access_key_id
}

output "secret_access_key" {
    value = aws_iam_access_key.xander.encrypted_secret
}