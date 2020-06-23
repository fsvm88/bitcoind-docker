FROM alpine:latest

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcoin

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN addgroup -g ${GROUP_ID} bitcoin && \
    adduser -u ${USER_ID} --disabled-password -G bitcoin -s /bin/ash -h /bitcoin bitcoin

RUN sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add bitcoin su-exec

ADD docker-entrypoint.sh ./bin /usr/local/bin/

VOLUME ["/bitcoin"]

EXPOSE 8332 8333 18332 18333

WORKDIR /bitcoin

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["btc_oneshot"]
