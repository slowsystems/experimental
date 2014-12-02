#!/bin/sh

##
## ss_pg_sync_master.sh
## 
## mizuki@slowsystems.co.jp
##

SRC=/var/lib/pgsql/9.0/data/
DST=postgres@172.26.33.32:/var/lib/pgsql/9.0/data/

sudo rsync -e ssh -av --delete --exclude=pg_xlog --exclude=postmaster.pid --exclude=pg_hba
.conf --exclude=postgresql.conf $SRC $DST

exit
