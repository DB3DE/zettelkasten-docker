#!/bin/bash
#this scripts builds the image

CONTAINERNAME="zettelkasten"
IMAGENAME="zettelkasten_image"
NETNAME="bnet"




if [ -n "$(docker container ls|grep $CONTAINERNAME)" ]; then
  echo "================================================="
  echo "A docker container $CONTAINERNAME runs, delteing and restarting"
  echo "================================================="
  echo ""

  docker stop $CONTAINERNAME
  docker rm $CONTAINERNAME
fi


#if [ -n "$(docker images|grep $IMAGENAME)" ]; then
#  echo "================================================="
#  echo "A docker image $IMAGENAME exists deleting it"
#  echo "================================================="
#  echo ""
#  docker image rm $IMAGENAME
#  #docker stop $CONTAINERNAME
#  #docker rm $CONTAINERNAME
#fi




docker build -t "$IMAGENAME" .
