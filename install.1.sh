#!/bin/bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server
systemctl start httpd
systemctl enable httpd
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
sudo yum install mod_wsgi -y
sudo yum install python3 -y 
pip3 install -U flask email_validator Flask-WTF
sudo yum install git -y
sudo git clone https://github.com/anieo/flask-blog /var/www/html/flask-blog
st='    WSGIDaemonProcess flaskapp threads=5
    WSGIScriptAlias / /var/www/html/flaskapp/flaskapp.wsgi

    <Directory flaskapp>
        WSGIProcessGroup flaskapp
        WSGIApplicationGroup %{GLOBAL}
        Order deny,allow
        Allow from all
    </Directory>
'
echo "$st" |sed -i '/DocumentRoot\ \/var\/www\/html/ r /dev/stdin' "/etc/apache2/sites-enabled/000-default.conf"
sudo systemctl start httpd  

sudo bash -c "echo \"$st\" >/etc/httpd/conf/httpd.conf"
sudo service httpd restart
