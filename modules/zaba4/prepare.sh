#!/bin/bash 

systemctl stop jenkins

/opt/puppetlabs/puppet/bin/gem uninstall rubyzip

rm -rf /var/lib/jenkins/plugins/*

puppet apply /etc/puppetlabs/code/environments/production/modules/plugin_tree/manifests/test.pp

#puppet apply ~/test.pp

systemctl start jenkins
