#!/usr/bin/bash
# TODO pass in command line args to, default to all if none are passed
if [ ! -x /usr/bin/ansible ]; then
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
fi
ansible-playbook -i ./local ./main.yaml --ask-become-pass --tags all
