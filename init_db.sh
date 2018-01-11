#!/usr/bin/env bash

init_database() {
    export database_ip=$1
    echo "Try connect to database"

#    for (( c=1; c<=5; c++ ))
#    do
#        if [ "$(mysql --host=$database_ip -P 3306 --user=root --password=12345 --execute='SELECT 1;')" ] ; then
#            echo "Connection successful."
            docker run --rm naqoda/mysql-client mysql --host="$database_ip" -P 3306 --user=root --password=12345 --wait --execute="CREATE USER IF NOT EXISTS 'juja'@'%' IDENTIFIED BY '12345';GRANT ALL PRIVILEGES ON *.* TO 'juja'@'%';CREATE DATABASE IF NOT EXISTS sscore_test;DROP DATABASE IF EXISTS verificator_test;CREATE DATABASE IF NOT EXISTS verificator_test;DROP DATABASE IF EXISTS messages_test;CREATE DATABASE messages_test;"
#            break
#        else
#            sleep 5
#            echo "Retry connection to database..."
#        fi
#    done
#}

 init_database "$1"
