#!/bin/bash

dnf install ansible -y
component=$1
environment=$2
# ansible-pull -U https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git -e component=mongodb main.yaml

ANSIBLE_URL=https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles-tf

mkdir -p $REPO_DIR
mkdir -p /var/log
touch /var/log/ansible.log

cd $REPO_DIR

if [ -d $ANSIBLE_DIR ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $ANSIBLE_URL
    cd $ANSIBLE_DIR
fi

echo "To get the instance id of catalogue to create ami"
ansible-playbook -e component=$component -e env=$environment  main.yaml
