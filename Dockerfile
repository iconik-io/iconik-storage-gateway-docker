FROM ubuntu:jammy
MAINTAINER iconik Media AB <info@iconik.io>
RUN apt-get update && \
    apt-get install -y ffmpeg imagemagick poppler-utils ghostscript dcraw exiftool locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt-get update && apt-get install -y wget gnupg && \
    wget -O - https://packages.iconik.io/deb/ubuntu/dists/jammy/iconik_package_repos_pub.asc | apt-key add - && \
    echo "deb [trusted=yes] https://packages.iconik.io/deb/ubuntu ./jammy main" > /etc/apt/sources.list.d/iconik.list && \
    apt-get update && \
    apt-get install -y iconik-storage-gateway
VOLUME /var/cantemo/iconik_storage_gateway/data
CMD /opt/cantemo/iconik_storage_gateway/iconik_storage_gateway \
    --iconik-url=${ICONIK_URL:-https://app-lb.iconik.io/} \
    --auth-token=${AUTH_TOKEN} \
    --app-id=${APP_ID} \
    --storage-id=${STORAGE_ID}
