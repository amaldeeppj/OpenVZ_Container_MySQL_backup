#!/bin/bash
#By Amaldeep <amaldeeppjcoc1@gmail.com>

#Define mysql backup script file location
mysqlbackupscript=/root/mysqlbackup

for i in `cat /proc/vz/veinfo | awk '{print $1}'|egrep -v '^0$'`;
do

        #Check if cron job for mysql backup is present in the container
        if vzctl exec $i crontab -l | grep -q mysqlbackup
        then
        
                continue
                
        else
        
                #Copy mysqlbackup script to the container
                cat $mysqlbackupscript | vzctl exec $i "cat - > /etc/mysqlbackup.sh"

                #Copy current crontab into a temp file in node and add the cron job entry of the mysql backup
                vzctl exec $i crontab -l > /root/tempcron
                echo "0 1 * * * /bin/bash /etc/mysqlbackup.sh" >> /root/tempcron

                #Copy the modified cronjob file to the container
                cat /root/tempcron | vzctl exec $i "cat - > /root/cronjobs"

                #Install the modified cron file
                vzctl exec $i crontab /root/cronjobs

                #Remove temp files
                vzctl exec $i rm -f /root/cronjobs
                rm -f /root/tempcron

        fi
done
