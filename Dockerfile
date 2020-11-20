FROM linuxserver/dokuwiki


# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOKUWIKI_RELEASE
LABEL build_version="Zettelkasten version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="bengineer"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	zip && \ 
 echo "**** install additional packages ****" && \
 apk add --no-cache \
	openssh-client \
	git && \
 ###################### Configs for Zettelkasten
 cp /app/dokuwiki/conf/local.php.dist /app/dokuwiki/conf/local.php && \
 echo "\$conf['title']       = 'Zettelkasten';        //what to show in the title" >> /app/dokuwiki/conf/local.php && \
 ###################### Plugin Install Start
 echo "[[Installed Plugins]]" >> /app/dokuwiki/data/pages/start.txt && \
 echo "====== Installed Plugins ======" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 ##############################  DRAW IO
 echo "**** Install plugin Drawio" && \
 echo "  * [[https://www.dokuwiki.org/plugin:drawio|Drawio]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/drawio.zip -L "https://github.com/lejmr/dokuwiki-plugin-drawio/archive/0.2.9.zip" && \
 mkdir /tmp/tmpunzip && \
 unzip -d /tmp/tmpunzip /tmp/drawio.zip && \
 mkdir /app/dokuwiki/lib/plugins/drawio && \
 mv /tmp/tmpunzip/*/* /app/dokuwiki/lib/plugins/drawio && \
 rm -r /tmp/tmpunzip && \
 rm /tmp/drawio.zip && \
 ##############################  ImagePaste
 echo "**** Install plugin ImgPaste" && \
 echo "  * [[https://www.dokuwiki.org/plugin:imgpaste|ImgPaste]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/ImgPaste.zip -L "https://github.com/cosmocode/dokuwiki-plugin-imgpaste/zipball/master" && \
 mkdir /tmp/tmpunzip && \
 unzip -d /tmp/tmpunzip /tmp/ImgPaste.zip && \
 mkdir /app/dokuwiki/lib/plugins/imgpaste && \
 mv /tmp/tmpunzip/*/* /app/dokuwiki/lib/plugins/imgpaste && \
 rm -r /tmp/tmpunzip && \
 rm /tmp/ImgPaste.zip && \
 ##############################  GitBackend
 echo "**** Install plugin gitbackend" && \
 echo "  * [[https://www.dokuwiki.org/plugin:gitbacked|gitbacked]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/gitbackend.zip -L "https://github.com/woolfg/dokuwiki-plugin-gitbacked/archive/master.zip" && \
 mkdir /tmp/tmpunzip && \
 unzip -d /tmp/tmpunzip /tmp/gitbackend.zip && \
 mkdir /app/dokuwiki/lib/plugins/gitbacked && \
 mv /tmp/tmpunzip/*/* /app/dokuwiki/lib/plugins/gitbacked && \
 rm -r /tmp/tmpunzip && \
 rm /tmp/gitbackend.zip && \
 ###################### Plugin Install END
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config