#!/bin/bash

dnf install ansible -y
ansible-pull -u https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git -e component=mongodb main.yaml
