export MERCURY_HOME=/usr/local/mercury-DEV
[ -d $MERCURY_HOME/bin ] && export PATH=$MERCURY_HOME/bin:$PATH
SEGO_GITHUB=$HOME/github/sebgod
MERCURY_FORK=$SEGO_GITHUB/mercury
MERCURY_MAIN=$HOME/github/mercury/mercury-dev
alias e="cd ${MERCURY_FORK}/extras"
alias mtu="pushd ${MERCURY_FORK}/extras && find .. -name *.m | xargs -- mtags && popd"
alias mdev="cd $MERCURY_MAIN"
alias ucd="cd ${SEGO_GITHUB}/mercury-unicode"
alias m="mmc --use-grade-subdirs --make"
alias sm="sudo mmc --use-grade-subdirs --make"
alias mmc-boot="sudo docker run -v=$${PWD}:/data sebgod/mercury-bootstrap:latest --use-grade-subdirs"
