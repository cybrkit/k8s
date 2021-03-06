#!/usr/bin/env bash
# DISTRIB_ID=Ubuntu
# DISTRIB_RELEASE=18.04
# DISTRIB_CODENAME=bionic
# DISTRIB_DESCRIPTION="Ubuntu 18.04.4 LTS"
# Installs K8S nodes using Ansible
# Requires Cluster Key and SSH Key

sudo apt update
while sudo fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
  echo "Waiting for APT..."
  sleep 5
done

sudo apt-mark unhold python3 python3-pip
sudo apt install -y python3=3.6.7-1~18.04 python3-pip=9.0.1-2.3~ubuntu1.18.04.1 curl apt-transport-https git sshpass
sudo apt-mark hold python3 python3-pip

pip3 install ansible==2.9.5

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_REMOTE_TMP=/tmp/k8s_lab
export PATH=$PATH:$HOME/.local/bin:/usr/local/bin
ansible-playbook ../playbooks/installation/main.yaml -i inventory.ini