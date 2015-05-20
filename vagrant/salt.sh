#!/bin/bash

echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" >> /etc/apt/sources.list
wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -

# install salt
apt-get update
apt-get install -y salt-minion


