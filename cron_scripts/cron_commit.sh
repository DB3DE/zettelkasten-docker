#!/bin/bash

OUTPUT="/tmp/log_cron"
CONTAINERNAME="zettelkasten"

echo "Commit: $(date)" >>$OUTPUT
/usr/bin/docker container ls|grep Up |grep "$CONTAINERNAME" >>$OUTPUT ||exit 1
/usr/bin/docker exec -w /config/dokuwiki/data/gitrepo "$CONTAINERNAME" git add . >>$OUTPUT 2>1 
/usr/bin/docker exec -w /config/dokuwiki/data/gitrepo "$CONTAINERNAME" git commit -m "Added $(date +%Y%m%d-%H%M%S)" >>$OUTPUT 2>&1

