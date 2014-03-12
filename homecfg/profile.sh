alias cd..='cd ..'
alias home='cd ~'
alias mmc='mercury_compile --use-subdirs'
alias mmake='mmc --use-subdirs --make'
alias share='cd ~/Desktop/share'
alias edit='vim'
MERCURY_VERSION=mercury-rotd-2014-01-07
MERCURY_HOME=/usr/local/$MERCURY_VERSION
MERCURY_STDLIB_DIR=$MERCURY_HOME/lib/mercury
PATH=$PATH:$MERCURY_HOME/bin
# export MERCURY_HOME
# export MERCURY_VERSION
# export MERCURY_STDLIB_DIR
# export PATH
