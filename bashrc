alias gl="git log --oneline --all --graph --decorate"
alias gs="git status"
alias glu="git ls-files --others --exclude-standard"
alias cls=clear

GREEN="\[\e[1;32m\]"
BLUE="\[\e[1;34m\]"
RED="\[\e[1;31m\]"
YELLOW="\[\e[1;33m\]"
WHITE="\[\e[1;97m\]"
COLOREND="\[\e[00m\]"

parse_git_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working ${GIT_WORD_FOR_TREE-tree} clean" ]]
    then
        echo -e "${WHITE}$branch${COLOREND}"
    else
        echo -e "${RED}$branch${COLROEND}"
    fi
}

prompt() {
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(parse_git_branch)\[\033[00;37m\]\$ "
}

PROMPT_COMMAND=prompt
