#!/bin/bash

alias docker-img="sudo docker images"
alias docker-rmi="sudo docker rmi"
alias docker-info="sudo docker info"
alias docker-cleanup="sudo docker rm \`sudo docker ps --no-trunc -a -q\`"
alias docker-attach="sudo docker attach -sig-proxy=false"
alias docker-ps="sudo docker ps"
alias docker-unused="sudo docker rmi \`docker-img | grep \"<none>\" | sed -e 's/\s\+/ /g' | cut -d ' ' -f 3\`"
