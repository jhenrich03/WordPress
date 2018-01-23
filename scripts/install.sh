#!/bin/bash

#install the puppet-agent if it's not already

if ! apt list --installed 2> /dev/null | grep -q puppet-agent; then

sudo wget -O "/tmp/puppet5-release-trusty.deb" https://apt.puppetlabs.com/puppet5-release-trusty.deb
sudo dpkg -i "/tmp/puppet5-release-trusty.deb"
sudo apt-get update
sudo apt-get install puppet-agent -y

fi

#install the puppetlabs mysql module on the database server
HOSTNAME=$(hostname)

if [ $HOSTNAME = 'dbserver' ]; then

/opt/puppetlabs/bin/puppet module install puppetlabs-mysql --modulepath="/vagrant/modules"

fi