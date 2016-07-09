#!/bin/bash

echo "--- Start Script ---"
useradd empuron
usermod -a -G wheel empuron
yum install epel-release -y 2>/dev/null
yum install -y salt-minion 2>/dev/null
mkdir /srv/salt
chmod 777 /srv/salt
service salt-minion start
echo "--- End Script ---"
