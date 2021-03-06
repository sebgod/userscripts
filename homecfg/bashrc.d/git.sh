export GIT_AUTHOR_NAME="Sebastian Godelet"
export GIT_AUTHOR_EMAIL="sebastian.godelet@outlook.com"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

[ -d /usr/lib/git-core ] && export PATH=/usr/lib/git-core:$PATH

git_branch_bin="git branch"
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
alias gm="git checkout master"
alias gs="git status"
alias gsu="git status -uno"
alias gd="git diff"
alias gdm="git diff master"
alias gd1="git diff @~1 @"
alias gd2="git diff @~2 @"
alias ga="git add"
alias gc="git commit"
alias gca="git commit -v -a"
alias gcam="git commit --amend -v"
alias gcb="git checkout -b"
alias gl="git log"
alias gll="git gr"
alias gu="git up"
alias guf="git checkout master && git up && git ff"
alias git-gr="git gr"
alias git-bv="git bv"
alias git-ff="git ff"
alias gumm="git checkout master && git up && git ff && git merge upstream/master"

# useful functions
function git-sego()
{
    cd ~/github/sebgod
    git clone https://github.com/sebgod/$1
}
