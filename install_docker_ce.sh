#!/bin/bash
# install instructions from https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 2) Add current user to docker group to allow usage of docker commands without root privileges. You will need to restart your OS after running this command for the group permissions to be applied.
sudo usermod -a -G docker $USER
echo "${USER} has been added to the docker group. To make this change active, enabling the user to use docker command without sudo, you will need to restart your OS!"
echo "Please run: sudo reboot"

