#!/bin/bash 

#$ lsb_release -a
#No LSB modules are available.
#Distributor ID: Ubuntu
#Description:    Ubuntu 18.04.6 LTS
#Release:        18.04
#Codename:       bionic

UBUNTU_CODENAME=bionic
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible
ansible-galaxy collection install community.docker