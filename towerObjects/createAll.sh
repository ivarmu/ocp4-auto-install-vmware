#!/usr/bin/env bash

ansible-playbook -i inventories/inventory.tower create-tower-venv.yml --vault-password-file ../.vault-password-file
ansible-playbook config-tower.yml --vault-password-file ../.vault-password-file

