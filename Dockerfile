FROM ubuntu:bionic
MAINTAINER Cantemo <info@cantemo.com>
ENV INSTALL_DIR=/opt/cantemo/iconik_storage_gateway \
    DEBEMAIL=info@cantemo.com \
    DEBFULLNAME=Cantemo
RUN bash -c 'printf """ \
\nDEBEMAIL="$DEBEMAIL" \
\nDEBFULLNAME="$DEBFULLNAME" \
\nexport DEBEMAIL DEBFULLNAME\n""" >> $HOME/.bashrc' \
    . $HOME/.bashrc
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/ffmpeg-4 && \
    apt-get install -y ffmpeg imagemagick poppler-utils ghostscript ufraw-batch
ADD policy.xml /etc/ImageMagick-6/policy.xml
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt-get update && apt-get install -y wget gnupg && \
    wget -O - https://packages.iconik.io/deb/ubuntu/dists/bionic/iconik_package_repos_pub.asc | apt-key add - && \
    echo "deb [trusted=yes] https://packages.iconik.io/deb/ubuntu ./bionic main" > /etc/apt/sources.list.d/iconik.list && \
    apt-get update && \
    apt-get install -y iconik-storage-gateway
CMD $INSTALL_DIR/iconik_storage_gateway \
    --iconik-url=${ICONIK_URL:-https://app-lb.iconik.io/} \
    --auth-token=${AUTH_TOKEN} \
    --app-id=${APP_ID} \
    --storage-id=${STORAGE_ID} \
    --debug=${DEBUG:-False}
