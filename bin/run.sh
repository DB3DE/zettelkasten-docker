#!/bin/bash
#this script generate the docker image for zettelkasten and starts it

CONTAINERNAME="zettelkasten"
IMAGENAME="zettelkasten_image"
NETNAME="bnet"
HTTPPORT="8083"
SSLPORT="8443"
PERSISTEND="/data/zettelkasten"

if [ -n "$(docker container ls --all|grep $CONTAINERNAME)" ]; then
  echo "================================================="
  echo "A docker container $CONTAINERNAME runs, delteing and restarting"
  echo "================================================="
  echo ""

  docker stop $CONTAINERNAME
  docker rm $CONTAINERNAME
fi


if [ ! -f "$PERSISTEND" ]; then
  echo "Data path doesnt exist - creating $PERSISTEND"
  mkdir -p "$PERSISTEND"
fi
 



docker run -d --name="$CONTAINERNAME" -e PUID=1000 -e PGID=1000  --network $NETNAME -e TZ=Europe/Berlin  -p "$HTTPPORT":80  -p "$SSLPORT":443 -v "$PERSISTEND":/config   --restart unless-stopped "$IMAGENAME"
echo "Wait 20s to make sure everything initialized"
sleep 20

echo "Fixing in the image"
docker exec -it -w /app/dokuwiki/data "$CONTAINERNAME" ln -s /config/dokuwiki/data/gitrepo .
docker exec -it -w /config/dokuwiki/data "$CONTAINERNAME" chown -R abc:abc gitrepo


echo ""
echo "================================================================"
echo "Currently running"
docker container ls|grep zettel
