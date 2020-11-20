# zettelkasten-docker
My Version of a Zettelkasten with Dokuwiki on Docker

## You are now on the branch for raspberrys

## Installation

1) Install docker https://docs.docker.com/get-docker/
2) I recommend using gitea as a git server. If you use this do the following:
   * Create a private Network for connecting Zettelkasten and the gitea git sever
     <code>
       docker network create --driver bridge git-net
     </code>
   
   * Than install and start the gitea server
     <code>
	     sudo docker run -d \
	       --name="gitea" \
	       -e PUID=1000 -e PGID=1000 \
	       -p 3000:3000 -p 222:22  \
	       --network git-net \
	       --restart unless-stopped \
	       -v /data/gitea:/data \
	       -v /etc/timezone:/etc/timezone:ro \
	       -v /etc/localtime:/etc/localtime:ro \
	       kunde21/gitea-arm
    </code>

   * config the gitea server

3) Clone this repo to some directory
4) Edit the config file for your needs
5) Run the init image script:
   <code>
   	 chmod +x bin/init_image.sh
     ./bin/init_image.sh
   </code>
6) Take care of you ssh key. One was generated for you in $DATAPATH/keys
   either exchange for your keys or configure your git server with them
7) If you plan to expose this instance get some proper Certs and exchange the files in $DATAPATH/keys
8) Optional: Change the default commit username and email in $DATAPATH/dokuwiki/conf/local.php
