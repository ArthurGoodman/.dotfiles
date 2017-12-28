alias gl="git log --oneline --all --graph --decorate"
alias gs="git status"
alias gd="git diff"
alias glu="git ls-files --others --exclude-standard"
alias cls=clear

        RED="\[\e[0;31m\]"
     YELLOW="\[\e[1;33m\]"
      GREEN="\[\e[0;32m\]"
       BLUE="\[\e[1;34m\]"
     PURPLE="\[\e[0;35m\]"
  LIGHT_RED="\[\e[1;31m\]"
LIGHT_GREEN="\[\e[1;32m\]"
      WHITE="\[\e[1;37m\]"
 LIGHT_GRAY="\[\e[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

parse_git_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
    status=`git status 2> /dev/null`
    if [[ $(echo ${status} | grep "nothing to commit") ]] ; then
        echo " ${WHITE}${branch}${COLOR_NONE}"
    elif [[ $(echo ${status} | grep "nothing added to commit but untracked files present") ]] ; then
        echo " ${YELLOW}${branch}${COLOR_NONE}"
    else
        echo " ${LIGHT_RED}${branch}${COLOR_NONE}"
    fi
}

function set_git_branch() {
    BRANCH=$(parse_git_branch)
}

function set_prompt_symbol() {
    if test $1 -eq 0 ; then
        PROMPT_SYMBOL="\$"
    else
        PROMPT_SYMBOL="${RED}\$${COLOR_NONE}"
    fi
}

function set_virtualenv() {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${PURPLE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
    fi
}

# Set the full bash prompt.
function set_bash_prompt() {
    set_prompt_symbol $?
    set_virtualenv
    set_git_branch
    PS1="
${PYTHON_VIRTUALENV}${LIGHT_GREEN}\u@\h${COLOR_NONE}:${BLUE}\w${COLOR_NONE}${BRANCH}
${PROMPT_SYMBOL} "
}

PROMPT_COMMAND=set_bash_prompt
