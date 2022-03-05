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
	git \
	zip && \
 ###################### Configs for Zettelkasten
 cp /app/dokuwiki/conf/local.php.dist /app/dokuwiki/conf/local.php && \
 echo "\$conf['title']       = 'Zettelkasten';        //what to show in the title" >> /app/dokuwiki/conf/local.php && \
 ###################### Plugin Install Start
 echo "[[Installed Plugins]]" >> /app/dokuwiki/data/pages/start.txt && \
 echo "====== Installed Plugins ======" > /app/dokuwiki/data/pages/installed_plugins.txt && \
 ##############################  DRAW IO
 echo "**** Install plugin Drawio" && \
 echo "  * [[https://www.dokuwiki.org/plugin:drawio|Drawio]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/drawio.zip -L "https://github.com/lejmr/dokuwiki-plugin-drawio/archive/refs/tags/0.2.10.zip" && \
 mkdir /tmp/tmpunzip && \
 unzip -d /tmp/tmpunzip /tmp/drawio.zip && \
 rm -rf /app/dokuwiki/lib/plugins/drawio && \
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
 rm -rf /app/dokuwiki/lib/plugins/imgpaste && \ 
 mkdir /app/dokuwiki/lib/plugins/imgpaste && \
 mv /tmp/tmpunzip/*/* /app/dokuwiki/lib/plugins/imgpaste && \
 rm -r /tmp/tmpunzip && \
 rm /tmp/ImgPaste.zip && \
 ##############################  dw2pdf pdf export
 echo "**** Install plugin dw2pdf" && \
 echo "  * [[https://www.dokuwiki.org//plugin:dw2pdf|dw2pdf]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/dw2pdf.tar.gz -L "https://github.com/splitbrain/dokuwiki-plugin-dw2pdf/tarball/master" && \
 mkdir /tmp/tmpunzip && \
 tar -xf /tmp/dw2pdf.tar.gz -C /tmp/tmpunzip/ && \
 rm -rf /app/dokuwiki/lib/plugins/dw2pdf && \
 mkdir /app/dokuwiki/lib/plugins/dw2pdf && \
 mv /tmp/tmpunzip/*/* /app/dokuwiki/lib/plugins/dw2pdf && \
 rm -r /tmp/tmpunzip && \
 rm /tmp/dw2pdf.tar.gz && \
 ##############################  GitBackend
 echo "**** Install plugin gitbackend" && \
 echo "  * [[https://www.dokuwiki.org/plugin:gitbacked|gitbacked]]" >> /app/dokuwiki/data/pages/installed_plugins.txt && \
 curl -o /tmp/gitbackend.zip -L "https://github.com/woolfg/dokuwiki-plugin-gitbacked/archive/master.zip" && \
 mkdir /tmp/tmpunzip && \
 unzip -d /tmp/tmpunzip /tmp/gitbackend.zip && \
 rm -rf /app/dokuwiki/lib/plugins/gitbacked && \
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
