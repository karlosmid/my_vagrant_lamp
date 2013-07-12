#!/usr/bin/env bash
rm -rf /var/www
ln -fs /vagrant/bopsky /var/www
sudo touch /etc/httpd/conf.d/default-documentroot
sudo chmod o+w  /etc/httpd/conf.d/default-documentroot
sudo echo 'DocumentRoot /var/www' > /etc/httpd/conf.d/default-documentroot
sudo service iptables stop
