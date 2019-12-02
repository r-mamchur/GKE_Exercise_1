#!/bin/bash

wget https://download.moodle.org/download.php/direct/stable38/moodle-3.8.tgz -O - | tar -xz -f - -C /var/www/
mv -f /var/www/moodle /var/www/html 
mkdir /var/www/moodledata

#wget https://download.moodle.org/langpack/3.8/uk.zip
# chmod 0777 /var/www/moodledata -R
chmod 777 /var/www -R

rm moodle-latest-36.tgz -f
rm uk.zip -f

php /var/www/html/admin/cli/install.php --wwwroot=http://moodle.example.com --dataroot=/var/www/moodledata --dbtype=mysqli --dbhost=mysql --dbname=moodle --dbuser=moodle --dbpass="Passw0rd(" --fullname="Moodle forever" --adminpass="Passw0rd("  --shortname="Moodle site" --non-interactive --agree-license --lang=ua

chown apache:apache /var/www/ -R

echo "Ok" > /var/www/ready

chmod 777 /var/www/ready 