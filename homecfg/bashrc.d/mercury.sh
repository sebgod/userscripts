SEGO_GITHUB=$HOME/github/sebgod
MERCURY_FORK=$SEGO_GITHUB/mercury
alias mdev="cd ${MERCURY_FORK}"
alias ucd="cd ${SEGO_GITHUB}/mercury-unicode"
alias gosr="cd ${SEGO_GITHUB}/shift-reduce"
alias m="mmc --use-grade-subdirs --make"
alias sm="sudo mmc --use-grade-subdirs --make"
alias mmc-boot="sudo docker run -v=$${PWD}:/data sebgod/mercury-bootstrap:latest --use-grade-subdirs"
alias agm="ag --mercury"
