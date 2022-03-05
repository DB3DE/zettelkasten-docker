#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source "$SCRIPTPATH/../config"
PERSISTEND=$(realpath "$PERSISTEND")

echo ""
echo "########################################"
echo "Image Name: $IMAGENAME"
echo "Containername: $CONTAINERNAME"
echo "Data will be stored here: $PERSISTEND" 
echo "Upstream gitrepo will be: $REPO"
echo "########################################"

echo ""
echo "Pull and Push of all Data - just in case"
docker exec -w /config/dokuwiki/data/gitrepo zettelkasten git pull 
docker exec -w /config/dokuwiki/data/gitrepo zettelkasten git push 


echo ""
echo "Stopping container"
docker stop "$CONTAINERNAME"

echo "Deleting old container"
docker rm "$CONTAINERNAME"



echo ""
echo "Building image for $IMAGENAME"
docker build -t "$IMAGENAME" "$SCRIPTPATH/../"


echo ""
echo "Starting container"
docker run -d --name="$CONTAINERNAME" -e PUID=1000 -e PGID=1000   --network bnet -e TZ=Europe/Berlin  -p "$HTTPPORT":80  -p "$SSLPORT":443 -v "$PERSISTEND":/config   --restart unless-stopped "$IMAGENAME"
echo "Wait 20s to make sure everything initialized"
sleep 20

echo "Fixing in the image"
docker exec -it -w /app/dokuwiki/data "$CONTAINERNAME" ln -s /config/dokuwiki/data/gitrepo .
docker exec -it -w /config/dokuwiki/data "$CONTAINERNAME" chown -R abc:abc gitrepo
echo "Now stuff should work - try http://$HOSTNAME:$HTTPPORT"

