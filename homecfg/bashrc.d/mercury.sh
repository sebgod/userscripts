[ -z $MERCURY_HOME ] || ( [ -d $MERCURY_HOME/bin ] && export PATH=$MERCURY_HOME/bin:$PATH )
MERCURY_FORK=$HOME/github/sebgod/mercury
MERCURY_MAIN=$HOME/github/mercury/mercury-dev
alias e="cd ${MERCURY_FORK}/extras"
alias mtu="pushd ${MERCURY_FORK}/extras && find .. -name *.m | xargs -- mtags && popd"
alias mdev="cd $MERCURY_MAIN"
alias m="mmc --use-grade-subdirs --make"
alias sm="sudo mmc --use-grade-subdirs --make"
