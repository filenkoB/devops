#!/bin/bash
# Install docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
usermod -aG docker ubuntu

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Run Jenkins docker instance

docker pull bogdanfilenko/jenkins-devops:lts
docker run --name jenkins_server -d -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=admin \
   --env AWS_ACCESS_KEY_ID=AKIA3QISMVTKEYAQZ3IK --env AWS_SECRET_ACCESS_KEY=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 bogdanfilenko/jenkins-devops:lts