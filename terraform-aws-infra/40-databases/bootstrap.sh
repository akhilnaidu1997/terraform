#!/bin/bash

dnf install ansible -y
component=$1
# ansible-pull -U https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git -e component=mongodb main.yaml

ANSIBLE_URL=https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles-tf

mkdir -p $REPO_DIR
mkdir -p /var/log
touch ansible.log

cd $REPO_DIR

if [ -d $ANSIBLE_DIR ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $ANSIBLE_URL
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=$component main.yaml
