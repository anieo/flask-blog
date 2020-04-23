#!/bin/bash

sudo yum install httpd -y
sudo yum install mod_wsgi -y
sudo yum install python3 -y 
pip3 install -U flask email_validator Flask-WTF
sudo yum install git -y
git clone https://github.com/anieo/flask-blog /var/www/html/flask-blog
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
sudo service httpd restart
