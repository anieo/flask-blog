#!/bin/bash
# Create the unprivileged user
sudo adduser flask-blog
# sudo passwd flask-blog

# Create our project directory
sudo -u flask-blog cd ~flask-blog/
sudo -u flask-blog git clone https://github.com/anieo/flask-blog 
sudo -u flask-blog cd flask-blog

# init and activate a python-virtualenv with prereqs
sudo -u flask-blog virtualenv -p python3 env
sudo -u flask-blog source env/bin/activate
sudo cp flask-blog.service /etc/systemd/system/flask-blog.service

sudo systemctl enable flask-blog
sudo systemctl start flask-blog

sudo cp  httpd.conf /etc/httpd/conf/httpd.conf

sudo systemctl enable httpd
sudo systemctl start httpd
