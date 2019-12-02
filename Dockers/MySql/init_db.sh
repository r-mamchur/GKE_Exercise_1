#!/bin/bash

if [ ! -d /var/lib/mysql/wp ]; then
   rm -rf /var/lib/mysql/*

   mysqld --initialize
   sleep 3
   # conf connect to MySql
   # password - Passw0rd!
   MYSQL_TEMP_PWD=`cat /var/log/mysqld.log | grep 'A temporary password is generated' | awk -F'root@localhost: ' '{print $2}'`

   # background
   nohup mysqld 2> /tmp/my_sql &
  sleep 3

   mysqladmin -u root -p`echo $MYSQL_TEMP_PWD` password 'Passw0rd!'
   cat << EOF > ~/.my.cnf
  [client]
  user=root
  password=Passw0rd!
EOF
   chmod 600 ~/.my.cnf

   # DB and User for WordPress
   echo "CREATE DATABASE wp DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; "  | mysql
   echo "GRANT ALL PRIVILEGES ON wp.* TO 'wp' IDENTIFIED BY 'Passw0rd('; " | mysql

   # DB and User for Moodle
   echo "CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; "  | mysql
   echo "GRANT ALL PRIVILEGES ON moodle.* TO 'moodle' IDENTIFIED BY 'Passw0rd('; " | mysql

   # We need to run MySql in foreground
   mysqladmin shutdown
   sleep 3
fi

