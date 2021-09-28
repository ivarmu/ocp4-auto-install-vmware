Role Name
=========

Role to install pip libraries or depencies into a tower virtual environment

Requirements
------------

Tested in ansible 2.9.1 and Tower 3.6.4-1

Role Variables
--------------

virtualenv_path: /var/lib/awx/venv/ansible
proxyserver: 127.0.0.1
proxyport: 8080
proxyuser: test
proxypass: test
pip_extra_args: "--trusted-host pypi.python.org"
useproxy: true
list_pip_package:
  - six
  - openpyxl
  - configparser

Dependencies
------------


Example Playbook
----------------

- hosts: pipLibdep
  gather_facts: yes
  become: yes
  become_method: sudo
  become_user: root
  remote_user: ansible
  vars:
    virtualenv_path: /var/lib/awx/venv/ansible
    proxyserver: proxy-server.lab.example.com
    proxyport: 8080
    proxyuser: proxy-user
    proxypass: proxy-sup3rScr3tP4$$
    pip_extra_args: "--trusted-host pypi.python.org"
    useproxy: true
    list_pip_package:
      - six
      - openpyxl
      - configparser
  roles:
    - role: ../roles/tower-piplibdep

License
-------

GPLv3

Author Information
------------------

silvinux - silvinux7@gmail.com
