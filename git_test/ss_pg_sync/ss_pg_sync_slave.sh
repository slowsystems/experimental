#!/bin/sh

##
## ss_pg_sync_slave.sh
##
## mizuki@slowsystems.co.jp
##

DIR_WORK=/home/mcury/ss_db_sync

DIR_PG=/var/lib/pgsql/9.0
DIR_PGDATA=$DIR_PG/data

TODAY=`date +"%Y%m%d"`

BACKUP=$DIR_PG/"data_"$TODAY
echo $BACKUP

sudo cp -fr $DIR_PGDATA $BACKUP
chown -R postgres:postgres $BACKUP

for F in postgresql.conf pg_hba.conf recovery.conf
do
    sudo cp -f $DIR_PGDATA/$F $DIR_WORK
    chown mcury:mcury $DIR_WORK/$F
done


sudo /etc/init.d/postgresql-9.0 stop

echo "Hold on and execute rsync from oasis1."
echo "Enter y or n when it's done."

read p

if [ "$p" = "y" ];then

    for F in postgresql.conf pg_hba.conf recovery.conf
    do
        sudo cp -f $DIR_WORK/$F $DIR_PGDATA
        chown postgres:postgres $DIR_PGDATA/$F
    done

    sudo /etc/init.d/postgresql-9.0 start
    echo "done!"
else
    echo "canceled"
fi

exit