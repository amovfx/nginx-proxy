#!/bin/bash

#read secrets
DO_TOKEN=$(cat /Users/andrew/git/nginx-proxy/secrets/do_token.txt)
DO_IMAGE=ubuntu-22-04-x64


#init

init() {
    REPO=$(basename `git rev-parse --show-toplevel`)
    #docker-machine create --driver digitalocean --digitalocean-access-token $DO_TOKEN --digitalocean-image $DO_IMAGE $REPO-1
    docker-machine create --driver digitalocean \
    --digitalocean-image ubuntu-22-04-x64 \
    --digitalocean-size s-1vcpu-1gb \
    --digitalocean-region nyc3 \
    --digitalocean-access-token $DO_TOKEN \
    $REPO-2
    eval $(docker-machine env $REPO)
}

clean() {
    docker-machine rm $REPO-1
    docker-machine rm $REPO-2 --force
}

reload() {
    source /Users/andrew/git/nginx-proxy/hydra-source.sh
}
