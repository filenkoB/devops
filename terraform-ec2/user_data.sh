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

# Run Jenkins docker instance
mkdir ~/jenkins_storage
sudo chown -R 1000:1000 ~/jenkins_storage

docker pull bogdanfilenko/jenkins-devops:lts
docker run --name jenkins_server -d -p 8080:8080 -p 50000:50000 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=admin -v ~/jenkins_storage:/var/jenkins_home bogdanfilenko/jenkins-devops:lts