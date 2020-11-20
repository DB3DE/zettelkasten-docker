#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo $SCRIPTPATH


source "$SCRIPTPATH/../config"
PERSISTEND=$(realpath "$PERSISTEND")


echo "Image Name: $IMAGENAME"
echo "Containername: $CONTAINERNAME"
echo "Data will be stored here: $PERSISTEND" 
echo "Upstream gitrepo will be: $REPO"


docker exec -it -w /config/dokuwiki/data "$CONTAINERNAME" rm -rf gitrepo
docker exec -it -w /config/dokuwiki/data "$CONTAINERNAME" ssh-agent bash -c "ssh-add /config/keys/id-rsa; git clone $REPO gitrepo"
docker exec -it -w /config/dokuwiki/data/gitrepo "$CONTAINERNAME" git config core.sshCommand 'ssh -i /config/keys/id-rsa -o "UserKnownHostsFile=/config/keys/known_hosts" -F /dev/null'
docker exec -it -w /config/dokuwiki/data "$CONTAINERNAME" chown -R abc:abc gitrepo

