#!/bin/bash
sudo apt install software-properties-common
sudo add-apt-repository -y  ppa:nginx/stable
sudo apt-get update
sudo apt-get install -y nginx php7.2-fpm php7.2-mysql mysql-server 
sudo apt-get install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
curl -LO https://wordpress.org/latest.tar.gz
sudo tar xzvf /latest.tar.gz
curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /text
       
