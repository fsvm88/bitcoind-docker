FROM fedora:37

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcoin

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN mkdir -p /usr/local/bin

ADD https://github.com/tianon/gosu/releases/download/1.16/gosu-amd64 /usr/local/bin/gosu

RUN chown root.root /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    groupadd -g ${GROUP_ID} bitcoin && \
    useradd -u ${USER_ID} -g bitcoin -s /bin/bash -d /bitcoin -m bitcoin && \
    dnf update -y && \
    dnf install -y bitcoin-core-server && \
    dnf clean all && \
    rm -rf /var/cache/dnf

ADD docker-entrypoint.sh ./bin /usr/local/bin/

VOLUME ["/bitcoin"]
EXPOSE 8332 8333 18332 18333
WORKDIR /bitcoin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["btc_oneshot"]
