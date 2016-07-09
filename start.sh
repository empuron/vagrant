#!/bin/bash

echo "--- Start Script ---"
yum install epel-release -y 2>/dev/null
yum install -y salt-minion 2>/dev/null
mkdir /srv/salt
service salt-minion start
echo "--- End Script ---"
