#!/bin/bash
# install the CodeDeploy agent on Ubuntu Server
cd /home/ubuntu

sudo apt update
sudo apt install ruby-full -y
sudo apt install wget -y
sudo wget "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/local/bin/jq
sudo chmod +x /usr/local/bin/jq
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip > /dev/null 2>&1
sudo ./aws/install

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile

sudo service codedeploy-agent status
sudo service codedeploy-agent start
sudo service codedeploy-agent status
sudo systemctl enable codedeploy-agent

# install pritunl package
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo -H pip3 install --ignore-installed PyYAML
sudo pip3 install c7n
sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service



