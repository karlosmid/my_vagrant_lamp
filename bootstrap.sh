sudo iptables -F
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 5432 -j ACCEPT

sudo service iptables save
gem install chef
