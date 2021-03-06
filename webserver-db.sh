#!/bin/bash
apt install software-properties-common
add-apt-repository -y  ppa:nginx/stable
apt-get update
apt-get install -y nginx php7.2-fpm php7.2-mysql mysql-server
apt-get install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

#configure file wordpress
curl -LO https://wordpress.org/latest.tar.gz
tar xzvf /latest.tar.gz
#curl -s https://api.wordpress.org/secret-key/1.1/salt/ > /auth.txt
cp /wordpress/wp-config-sample.php /wordpress/wp-config.php
cd /
sed -i '49,56d' /wordpress/wp-config.php
sed -i '48r /auth.txt' /wordpress/wp-config.php
sed -i 's/database_name_here/nama-db/g' /wordpress/wp-config.php
sed -i 's/username_here/nama-pengguna/g' /wordpress/wp-config.php
sed -i 's/password_here/katasandi/g' /wordpress/wp-config.php
sed -i 's/localhost/alamat/g' /wordpress/wp-config.php
sed -i '38a\define('FS_METHOD', 'direct');' /wordpress/wp-config.php
sed -i 's/\r$//g' /wordpress/wp-config.php
cp -a /wordpress /var/www/
chown -R www-data:www-data /var/www/wordpress

#configure nginx
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default
cp /LEMP-Wp-master/wordpress.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/
systemctl restart php7.2-fpm
systemctl restart nginx.service

#configure mysql
mysql -h alamat -u nama-pengguna -p"katasandi" -e "CREATE DATABASE nama-db;"
mysql -h alamat -u nama-pengguna -p"katasandi" -e "GRANT ALL ON nama-db.* TO 'nama-pengguna'@'%';"
mysql -h alamat -u nama-pengguna -p"katasandi" -e "FLUSH PRIVILEGES;"
