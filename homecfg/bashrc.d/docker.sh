#!/bin/bash

alias docker-img="docker images"
alias docker-rmi="docker rmi"
alias docker-info="docker info"
alias docker-container-gc="docker rm \`docker ps --no-trunc -a -q\`"
alias docker-attach="docker attach -sig-proxy=false"
alias docker-ps="docker ps"
alias docker-img-gc="docker rmi \`docker-img | grep \"<none>\" | sed -e 's/\s\+/ /g' | cut -d ' ' -f 3\`"
