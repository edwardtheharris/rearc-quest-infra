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

There's no getting around the need to download the root user's access key id and secret key, so do that and use the AWS CLI to configure a profile named `root`. You will also need to generate a gpg key to prevent the created user's access key id and secret key being written in plaintext everywhere Terraform cares to write it.

```bash
export gpg_key_user=somegpgreference

aws configure --profile root
gpg --generate-key
gpg --export -o ${gpg_key_user}.gpg -a ${gpg_key_user}
```

Then set the variables required to set up the IAM user we'll actually be using to do the deployment, initialize the repository and apply the changes.

```bash
export TF_VAR_aws_profile=root
export TF_VAR_public_key_path=$HOME/.ssh/id_rsa.pub
export TF_VAR_shared_credentials_file=$HOME/.aws/credentials

terraform init
terraform plan
terraform apply
```
