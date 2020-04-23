#!/bin/bash
sudo yum install python3 -y 
pip3 install -U flask email_validation Flask-WTF

python3 flaskblog.py
