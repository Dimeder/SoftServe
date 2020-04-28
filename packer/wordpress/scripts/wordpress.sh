#!/bin/bash
yum update -y
amazon-linux-extras install php7.2 -y 
yum install httpd -y
cd /var/www/html
wget https://wordpress.org/wordpress-5.3.2.tar.gz
tar -xzf wordpress-5.3.2.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.3.2.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
chkconfig httpd on
service httpd start