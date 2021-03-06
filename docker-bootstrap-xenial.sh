#!/bin/sh
echo You need to run this script as root or sudo

echo updating system packages
sudo apt-get update -qy

echo installing the extra image packages
sudo apt-get install -qy linux-image-extra-$(uname -r) linux-image-extra-virtual

echo installing ca stuff
sudo apt-get install -qy apt-transport-https ca-certificates

echo adding GPG key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo adding sources for ubuntu docker in /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

echo updating packages again
sudo apt-get update -qy

echo removing any old docker stuff
sudo apt-get purge lxc-docker

echo verify using correct repo for docker
sudo apt-cache policy docker-engine

echo installing additional image packages
sudo apt-get install -qy linux-image-extra-$(uname -r)

echo finally installing docker
sudo apt-get install -qy docker-engine



echo finished installing docker... testing
sudo docker run hello-world

echo doing stuff so you dont have to user sudo for docker
sudo groupadd docker
sudo usermod -aG docker $USER
echo you probably need to logout and in again

