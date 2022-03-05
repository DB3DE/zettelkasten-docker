#!/bin/bash

OUTPUT="/tmp/log_cron"
CONTAINERNAME="zettelkasten"

echo "push $(date)" >>$OUTPUT
/usr/bin/docker container ls|grep Up |grep "$CONTAINERNAME" >>$OUTPUT ||exit 1

/usr/bin/docker exec -w /config/dokuwiki/data/gitrepo "$CONTAINERNAME" git pull >>$OUTPUT 2>&1 
/usr/bin/docker exec -w /config/dokuwiki/data/gitrepo "$CONTAINERNAME" git push >>$OUTPUT 2>&1
