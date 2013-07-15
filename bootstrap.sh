#!/usr/bin/env bash
#deploy bopsky php codebase to apache2
rm -rf /var/www
ln -fs /vagrant/bopsky /var/www
sudo touch /etc/httpd/conf.d/default-documentroot
sudo chmod o+w  /etc/httpd/conf.d/default-documentroot
sudo echo 'DocumentRoot /var/www' > /etc/httpd/conf.d/default-documentroot
#security down, so do not expose this VM to outher world!
sudo service iptables stop
#jenkins install, because chef cookbook failed!
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -nv
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum -y install jenkins
#gradle
wget http://services.gradle.org/distributions/gradle-1.6-all.zip -nv
unzip -of gradle-1.6-all.zip
#xvfb
sudo yum -y install xorg-x11-server-Xvfb
#phantomjs
npm install phantomjs
sudo ln -sf /home/vagrant/node_modules/phantomjs/bin/phantomjs /usr/bin/phantomjs
sudo ln -sf /usr/local/bin/node /usr/bin/node
chmod o+x /home/vagrant
#jshint
npm install -g jshint
sudo ln -sf /home/vagrant/node_modules/jshint/bin/jshint /usr/bin/jshint
#java
sudo ln -sf /usr/lib/jvm/jdk1.7.0_25/bin/java /usr/bin/java
