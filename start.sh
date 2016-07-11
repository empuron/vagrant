#!/bin/bash

echo "--- Start Script ---"
#useradd empuron >/dev/null
#usermod -a -G wheel empuron >/dev/null
#yum install epel-release -y >/dev/null
#yum install -y salt-minion >/dev/null
#yum install -y puppet-agent >/dev/null
curl -L https://www.opscode.com/chef/install.sh | bash
#mkdir /srv/salt >/dev/null
#chmod 777 /srv/salt >/dev/null
#service salt-minion start >/dev/null
echo "--- End Script ---"
