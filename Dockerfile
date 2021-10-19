FROM debian:11

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcoin

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

ADD docker-entrypoint.sh ./bin /usr/local/bin/
ADD sid.list /etc/apt/sources.list.d/
ADD apt_prefs /etc/apt/preferences.d/

RUN export DEBIAN_FRONTEND=noninteractive && \
    groupadd -g ${GROUP_ID} bitcoin && \
    useradd -u ${USER_ID} -g bitcoin -s /bin/bash -d /bitcoin bitcoin && \
    apt update && \
    apt install -qq -y --no-install-recommends ca-certificates dirmngr git gpg wget gosu bitcoind && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/bitcoin"]
EXPOSE 8332 8333 18332 18333
WORKDIR /bitcoin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["btc_oneshot"]
