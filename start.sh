#!/bin/bash

echo "--- Skript Start ---"
echo "Neues Passwort von Root Benutzer einrichten"
echo root | passwd --stdin root >/dev/null

echo "Setze Tastaturlayout auf Deutsch"
localectl set-keymap de >/dev/null

echo "Erstelle Docker Repo"
echo "[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg" > /etc/yum.repos.d/docker.repo

echo "Installiere Docker Engine"
yum install docker-engine -y >/dev/null

echo "Erstelle Epel Repo fuer Saltstack"
yum install epel-release -y >/dev/null

echo "Installiere und starte Saltstack"
yum install salt-minion -y >/dev/null
service salt-minion start >/dev/null
chkconfig salt-minion on >/dev/null

echo "Erstelle Salt Verzeichnis mit Berechtigungen"
mkdir /srv/salt >/dev/null
chmod 777 /srv/salt >/dev/null
echo "--- Skript Ende ---"
