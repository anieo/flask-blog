#!/bin/bash
yum -y install python34 python34-pip
# DO NOT use yum -y install python-virtualenv

sudo yum -y install python34 python34-devel python34-pip mod_proxy_uwsgi gcc
sudo pip3 install --upgrade pip
sudo pip3 install virtualenv flask uwsgi
