#!/usr/bin/env bash
#deploy bopsky php codebase to apache2
rm -rf /var/www
ln -fs /vagrant/bopsky /var/www
sudo touch /etc/httpd/sites-enabled/default
sudo chmod o+w /etc/httpd/sites-enabled/default
sudo sed 's/AllowOverride None/AllowOverride all/g' /etc/httpd/sites-available/default > /etc/httpd/sites-enabled/default
#mode_rewrite
#http://www.lavluda.com/2007/07/15/how-to-enable-mod_rewrite-in-apache22-debian/
#security down, so do not expose this VM to outher world!
sudo iptables -F
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 3306 -j ACCEPT
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 80 -j ACCEPT
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 443 -j ACCEPT
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 8080 -j ACCEPT
sudo iptables -A INPUT -i eth0 -s 10.0.2.2 -p tcp --destination-port 5000 -j ACCEPT

sudo service iptables save
#jenkins install, because chef cookbook failed!
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -nv -nc
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum -y install jenkins
#gradle
wget http://services.gradle.org/distributions/gradle-1.6-all.zip -nv -nc
unzip -of gradle-1.6-all.zip
#xvfb
sudo yum -y install xorg-x11-server-Xvfb
sudo yum --y install php-mysql
#/etc/php.ini set timezone="Europe/Zagreb"
chmod o+x /home/vagrant
#java
sudo ln -sf /usr/lib/jvm/jdk1.7.0_25/bin/java /usr/bin/java
sudo ln -sf /home/vagrant/.npm/requirejs/2.1.8/package/bin/r.js /usr/bin/r.js
sudo ln -sf /home/vagrant/node_modules/phantomjs/bin/phantomjs /usr/bin/phantomjs
sudo ln -sf /usr/local/bin/node /usr/bin/nodesudo
sudo ln -sf /home/vagrant/node_modules/jshint/bin/jshint /usr/bin/jshint
#run by after vagrant provision
#requirejs
npm install requirejs
#phantomjs
npm install phantomjs
#jshint
npm install jshint
#liquibase
sudo yum -y install dos2unix
sudo chmod u+x /opt/liquibase-2.0.4/liquibase
sudo dos2unix /opt/liquibase-2.0.4/liquibase
sudo ln -sf /opt/liquibase-2.0.4/liquibase /usr/bin/liquibase
echo 'you need to have mysql jdbc driver in my_vagrant_lamp'
#sudo pear config-set auto_discover 1
#sudo pear install pear.phpqatools.org/phpqatools pear.netpirates.net/phpDox
sudo yum -y install ImageMagick-devel
gem install chef
