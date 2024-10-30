#!/bin/bash

print_usage() {
  echo -e "\nUsage:\n\n$0 <target-ip> <target-username>\n"
}

[[ -z $1 || -z $2 ]] && print_usage && exit 1

ansible-galaxy collection install community.general &&
  ANSIBLE_SSH_ARGS='-C -o ForwardX11=yes -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no' \
    ansible-playbook --inventory $1, --user $2 --ask-pass --ask-become-pass playbooks/main.yml
