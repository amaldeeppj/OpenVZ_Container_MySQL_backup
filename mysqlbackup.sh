#!/bin/bash
#By Amaldeep <amaldeeppjcoc1@gmail.com>

#Todays date in ISO-8601 format:
DAY0=`date -I`

#Define retention period
RETENTION_PERIOD=2

#"RETENTION_PERIOD" days ago in ISO-8601 format
DAY2=`date -I -d "$RETENTION_PERIOD days ago"`

#Backup Directory
DIR=/home/MYSQL_BACKUPS

#Remove oldest backup directory
rm -rf $DIR/$DAY2

#Check if backup directory exists
if [ -d $DIR ]; then

    mkdir $DIR/$DAY0
    for DB in `mysql -e 'show databases'|awk '{print $1}'`;
    do mysqldump $DB |gzip > $DIR/$DAY0/$DB.sql.gz;
    done

else

    mkdir $DIR
    mkdir $DIR/$DAY0
    for DB in `mysql -e 'show databases'|awk '{print $1}'`;
    do mysqldump $DB |gzip > $DIR/$DAY0/$DB.sql.gz;
    done

fi
