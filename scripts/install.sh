#!/bin/sh
echo "Installing Python"
apt-get update
apt install software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt install python3.7
python --version

echo "Installing AWS CLI"
pip3 install --upgrade --user awscli