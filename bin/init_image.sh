#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source "$SCRIPTPATH/../config"
PERSISTEND=$(realpath "$PERSISTEND")

if [ -d "$PERSISTEND" ]; then
	echo "Persistend path exists! ($PERSISTEND)"
	echo "Will stop now"
	exit 1
else
	mkdir -p "$PERSISTEND"
fi

echo "Image Name: $IMAGENAME"
echo "Containername: $CONTAINERNAME"
echo "Data will be stored here: $PERSISTEND" 
echo "Upstream gitrepo will be: $REPO"


echo ""
echo "Building image"
docker build -t "$IMAGENAME" "$SCRIPTPATH/../"


echo ""
echo "Starting container once"
docker run -d --name="$CONTAINERNAME" -e PUID=1000 -e PGID=1000   --network git-net -e TZ=Europe/Berlin  -p "$HTTPPORT":80  -p "$SSLPORT":443 -v "$PERSISTEND":/config   --restart unless-stopped "$IMAGENAME"
echo "Stopping container"
docker stop "$IMAGENAME"



echo "Docker image should be generated"
echo "Start a container with the start command"
echo "Then you have to initialize according to the manual once"

exit 0