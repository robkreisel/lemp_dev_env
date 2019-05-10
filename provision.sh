#!/bin/bash

# Using single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='vagrant'

# update / upgrade
echo "Updating apt-get..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y upgrade > /dev/null 2>&1
sudo apt-get install software-properties-common > /dev/null 2>&1
sudo add-apt-repository ppa:ondrej/php > /dev/null 2>&1
sudo add-apt-repository ppa:ondrej/nginx > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1

# install git
echo "Installing Git..."
sudo apt-get install -y git > /dev/null 2>&1

# install nginx
echo "Installing Nginx..."
sudo apt-get install -y nginx > /dev/null 2>&1

# install php7-fpm
echo "Installing PHP..."
sudo apt-get install -y php7.3-fpm php7.3-mysql php7.3-xml php7.3-gd php7.3-zip php-mbstring > /dev/null 2>&1
# install mariadb and give password to installer
echo "Preparing MariaDB..."
sudo apt-get install -y debconf-utils > /dev/null 2>&1
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 > /dev/null 2>&1
sudo add-apt-repository 'deb [arch=amd64,i386] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu xenial main' > /dev/null 2>&1

echo "Updating apt-get..."
sudo apt-get update > /dev/null 2>&1

echo "Installing MariaDB..."
sudo apt-get install -y mariadb-server > /dev/null 2>&1

# Nginx Config
echo "Configuring Nginx..."
sudo cp /var/www/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

sudo rm -rf /etc/nginx/sites-enabled/default

# Restarting Nginx for config to take effect
echo "Restarting Nginx..."
sudo service nginx restart