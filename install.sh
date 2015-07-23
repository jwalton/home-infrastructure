#!/bin/bash
ansible-galaxy install -r requirements.yml
ansible-playbook ./ansible/playbooks/setup.yml
