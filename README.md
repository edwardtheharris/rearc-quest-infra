# rearc-quest-infra

Terraform and other related code required to deploy the rearc quest app.

## Rearc Quest app

This code is meant to deploy and run the [rearc quest](https://github.com/rearc/quest) web app.

## Usage

If you're starting from a fresh AWS account first thing is to install the AWS CLI. That is, after you've cloned this repository.

```bash
git clone https://github.com/edwardtheharris/rearc-quest-infra
cd rearc-quest-infra
```

### AWS CLI

This can be done cleanly with pipenv. Assuming you don't have pipenv but do have a Python 3 version with pip installed. . .

```bash
pip3 install pipenv
pipenv shell 
pipenv install
```

### First TF run

There's no getting around the need to download the root user's access key id and secret key, so do that and use the AWS CLI to configure a profile named `root`. You will also need to generate a gpg key to prevent the created user's access key id and secret key being written in plaintext everywhere Terraform cares to write it. Make sure to select RSA as the key type when you generate the key.

```bash
export gpg_key_user=somegpgreference

aws configure --profile root
gpg --full-generate-key
gpg --export ${gpg_key_user} | base64 > ${gpg_key_user}.gpg
```

Next configure the AWS profile to the root user, initialize the repository and apply the changes.

```bash
export TF_VAR_aws_profile=root

terraform init
terraform plan
terraform apply
```

Now we've got a key and which we can decode with gpg then use to configure the default aws profile. Finally, we unset the environment variable that tells terraform to use the root user instead of our IAM user.

```bash
terraform output -raw secret_access_key | base64 -D > /tmp/secret.gpg
gpg -d /tmp/secret.gpg
aws configure
unset TF_VAR_aws_profile
```
