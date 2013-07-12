#!/usr/bin/env bash
rm -rf /var/www
ln -fs /vagrant /var/www
sudo service iptables stop
