Role Name
=========

Role to create custom venv on Tower and install pip libraries or depencies into it

Requirements
------------

Tested in ansible 2.9.15 and Tower 3.8.1

Role Variables
--------------
```
venv_base_path: '/var/lib/awx/venv'
pip_extra_args: '--trusted-host pypi.python.org'
list_pip_package:
  - six
  - openpyxl
  - configparser
  - pandas
  - xlrd
  - str2bool
  - apypie
useproxy: false
```
Dependencies
------------


Example Playbook
----------------
```
- hosts: pipLibdep
  gather_facts: yes
  become: yes
  become_method: sudo
  become_user: root
  remote_user: ansible
  vars:
    venv_base_path: '/var/lib/awx/venv'
    pip_extra_args: '--trusted-host pypi.python.org'
    list_pip_package:
      - six
      - openpyxl
      - configparser
      - pandas
      - xlrd
      - str2bool
      - apypie
    useproxy: false
  roles:
    - role: ../roles/tower-piplibdep
```
License
-------

GPLv3

Author Information
------------------

flloreda - flloreda@redhat.com
