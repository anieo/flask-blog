#!/bin/bash

sudo yum install httpd -y
sudo yum install mod_wsgi -y
sudo yum install python3 -y 
pip3 install -U flask email_validator Flask-WTF
sudo yum install git -y
sudo git clone https://github.com/anieo/flask-blog /var/www/html/flask-blog
st='<VirtualHost *:80>

     ServerName localhost

     WSGIDaemonProcess hitme user=apache group=apache threads=2

     WSGIScriptAlias / /var/www/hitme/wsgi.py

     <Directory /var/www/hitme>
         Require all granted
     </Directory>

</VirtualHost>
'
sudo systemctl start httpd  
# echo "$st" |sed -i '/DocumentRoot\ \/var\/www\/html/ r /dev/stdin' "/etc/apache2/sites-enabled/000-default.conf"
sudo bash -c "echo \"$st\" >/etc/httpd/conf/httpd.conf"
sudo service httpd restart
