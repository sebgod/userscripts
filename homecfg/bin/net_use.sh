#!/bin/bash

[ -x ~/dev/sego ] || mkdir -p ~/dev/sego
[ -x ~/public ] || mkdir -p ~/public
sudo mount.cifs //fileserver.sorpetaler.de/office/text/sebastian ~/dev/sego -o user=$USER,dom=WOODY,rw,nounix,file_mode=0744,dir_mode=0744,uid=1000,gid=1000
sudo mount.cifs //fileserver.sorpetaler.de/c\$/dev/node.js/fileserver/public ~/public -o user=$USER,dom=WOODY,rw,nounix,file_mode=0744,dir_mode=0744,uid=1000,gid=1000
