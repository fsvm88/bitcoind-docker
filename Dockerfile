FROM alpine:3.16

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcoin

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

ADD docker-entrypoint.sh ./bin /usr/local/bin/

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    addgroup -g ${GROUP_ID} bitcoin && \
    adduser -u ${USER_ID} -G bitcoin -s /bin/ash -h /bitcoin -D bitcoin && \
    apk add --update --no-cache bitcoin gosu

VOLUME ["/bitcoin"]
EXPOSE 8332 8333 18332 18333
WORKDIR /bitcoin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["btc_oneshot"]
