#!/bin/bash

dnf install ansible -y
ansible-pull -U https://github.com/akhilnaidu1997/ansible-roboshop-roles-tf.git -e component=mongodb main.yaml
