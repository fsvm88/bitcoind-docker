# bitcoind-docker
Minimal bitcoind docker image based on Alpine
Most of the code is taken from https://github.com/kylemanna/docker-bitcoind,
and re-adapted for modern Alpine.

## Quick start
1. Create a data volume or folder to persist the blockchain data
    docker volume create --name=bitcoind-data
    OR
    mkdir -p /data/bitcoind

    docker run -v bitcoind-data:/bitcoin --name=bitcoind-node -d \
      -p 8333:8333 \
      -p 127.0.0.1:8332:8332 \
      fsvm88/bitcoind-docker

2. Verify that container is running
    $ docker ps
    CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS                  PORTS                                              NAMES
    218063fcc2ce        fsvm88/bitcoind-docker        "docker-entrypoint.s…"   4 minutes ago       Up 4 minutes            127.0.0.1:8332->8332/tcp, 0.0.0.0:8333->8333/tcp   bitcoind-node

3. You can check the bitcoind logs via
    docker logs -f bitcoind-node
