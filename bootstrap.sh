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
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -nv -nc
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum -y install jenkins
#gradle
wget http://services.gradle.org/distributions/gradle-1.6-all.zip -nv -nc
unzip -of gradle-1.6-all.zip
#xvfb
sudo yum -y install xorg-x11-server-Xvfb
chmod o+x /home/vagrant
#java
sudo ln -sf /usr/lib/jvm/jdk1.7.0_25/bin/java /usr/bin/java
sudo ln -sf /home/vagrant/node_modules/requirejs/bin/r.js /usr/bin/r.js
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
#database
echo 'in /etc/my.cnf edit bind-address=127.0.0.1 and after that restart mysqld'
