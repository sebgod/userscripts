# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

tput setaf 1>&/dev/null

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=verbose
export GIT_PS1_SHOWCOLORHINTS=true
if [ -r /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
    PROMPT_COMMAND='__git_ps1 "${PS1_PRE}" "\\\$ "'
fi
PS1_PRE='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'

# PS1='\033[01;32m\u@\h \033[01;34m\w$(__git_ps1 " (%s)")\033[00m\\$ '

# User specific aliases and functions
run_scripts()
{
	for script in $1/*; do
		[ -x "$script" ] || continue
		. $script
	done
}

run_scripts ~/.bashrc.d
