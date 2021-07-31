resource "aws_iam_user" "xander" {
  name = "xander"
  path = "/admins/"

  tags = {
    name = "Xander Harris"
  }
}

resource "aws_iam_user_policy_attachment" "admin-access" {
  user       = aws_iam_user.xander.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.xander.name
  encoding   = "SSH"
  public_key = file(var.public_key_path)
}

resource "aws_iam_access_key" "xander" {
  pgp_key = file(var.gpg_key_filename)
  user = aws_iam_user.xander.name
}
