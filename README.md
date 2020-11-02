# OpenVZ_Container_MySQL_backup
Bash script to copy the MySQL backup script to all containers of an OpenVZ node and add a cron job in the container to run the backup script 


Copy both the files mysqlbackup.sh and add_cron.sh to the node and specify the location of mysqlbackup.sh in add_cron.sh and run it.
The script mysqlbackup.sh is not meant to run in the node. The script add_cron.sh will copy it to the container and will add a cron to run it. 
Run the script add_cron.sh in the node. 
