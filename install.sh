#!/bin/bash
sudo apt-get update  -y
sudo apt install python3.6 -y
sudo apt install python3-pip -y
sudo apt install apache2 -y
sudo apt install libapache2-mod-wsgi -y

sudo rm /usr/bin/python
sudo ln-n /usr/bin/python3.6 /usr/bin/python

sudo apt install virtualenv -y
sudo systemctl enable apache2.service
sudo systemctl start apache2.service

sudo usermod -a -G ubuntu
sudo chown -R ubuntu:ubuntu /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
pip3 install -U flask email_validator Flask-WTF

sudo apt install git -y
sudo git clone https://github.com/anieo/flask-blog /var/www/html/flask-blog
sudo cp  /var/www/html/flask-blog/flask.conf /etc/apache2/sites-available/flask.conf
sudo a2ensite flask.conf
virtualenv  /var/www/html/flask-blog/venv
source /var/www/html/flask-blog/venv/bin/activate
cd  /var/www/html/flask-blog/
pip install -r requirements.txt

sudo systemctl restart apache2.service