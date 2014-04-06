export GIT_AUTHOR_NAME="Sebastian Godelet"
export GIT_AUTHOR_EMAIL="sebastian.godelet+github@gmail.com"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

[ -d /usr/lib/git-core ] && export PATH=/usr/lib/git-core:$PATH

git_branch_bin=$(which git-branch 2>/dev/null)
function git-branch()
{
    local delete=no
    for arg; do
        [ "$arg" == "-D" ] && delete=yes
    done
    if [ "$delete" == "yes" ]; then
        $git_branch_bin -v $*
    else
        $git_branch_bin -v -a $*
    fi
}

# useful aliases
alias gm="git-checkout master"
alias gs="git-status"
alias gd="git-diff"
alias ga="git-add"
alias gc="git-commit"
alias gca="git-commit -v -a"
alias gcam="git-commit --amend -v"
alias gcb="git-checkout -b"
alias gl="git-log"
alias gll="git gr"
alias gu="git up"
