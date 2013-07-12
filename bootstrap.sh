#!/usr/bin/env bash
rm -rf /var/www
ln -fs /vagrant/bopsky /var/www
sudo service iptables stop
