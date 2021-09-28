#!/usr/bin/env bash

virtualenv --system-site-packages -p /bin/python2.7 virtualEnvironment2.7
source virtualEnvironment2.7/bin/activate
pip install -r python_requirements.txt -r python_requirements_vcenter.txt
deactivate
virtualenv --relocatable virtualEnvironment2.7
for file in virtualEnvironment2.7/bin/activate*; do sed -i "s,${PWD},\.," ${file} ; done
tar cvf - virtualEnvironment2.7/ | gzip -v9 > virtualEnvironment2.7.tar.gz

