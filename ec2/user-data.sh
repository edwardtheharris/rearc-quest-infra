#!/bin/bash

sudo yum -y update
sudo yum -y install curl git 
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install -y nodejs
mkdir -pv /app
cd /app
git clone https://github.com/rearc/quest .
npm install
node .
