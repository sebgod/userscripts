[ -z $MERCURY_HOME ] || ( [ -d $MERCURY_HOME/bin ] && export PATH=$MERCURY_HOME/bin:$PATH )
alias e="cd ~/github/sebgod/mercury/extras"
alias mdev="cd ~/github/mercury/mercury-dev"
alias m="mmc --use-grade-subdirs --make"
alias sm="sudo mmc --use-grade-subdirs --make"