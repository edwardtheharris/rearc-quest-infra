resource "aws_iam_user" "xander" {
  name = "xander"
  path = "/admins/"

  tags = {
    name = "Xander Harris"
  }
}

resource "aws_iam_user_policy_attachment" "admin-access" {
    user = aws_iam_user.xander.name
    policy_arn = 'arn:aws:iam::aws:policy/AdministratorAccess'
}
