#!/bin/bash

alias docker-img="sudo docker images"
alias docker-rmi="sudo docker rmi"
alias docker-info="sudo docker info"
alias docker-cleanup="sudo docker rm \`sudo docker ps --no-trunc -a -q\`"

