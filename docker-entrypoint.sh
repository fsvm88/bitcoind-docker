#!/bin/sh

set -e

export PATH=$PATH:/usr/local/bin

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [[ "${1#-}" != "$1" ]] || [[ "${1%.conf}" != "$1" ]]; then
    set -- btc_oneshot "$@"
fi

# allow the container to be started with `--user`
if [[ "$1" == 'btc_oneshot' && "$(id -u)" = '0' ]]; then
    chown -R bitcoin.bitcoin .
    exec gosu bitcoin "$0" "$@"
fi

exec "$@"
