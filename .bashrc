#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

################################################################################
# Common
################################################################################

# Disable ctrl-s and ctrl-q
stty -ixon

# Allows you to cd into directory merely by typing the directory name
shopt -s autocd

# Infinite history
HISTSIZE= HISTFILESIZE=

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Fix color output of some programs in st
if [ "$TERM" = "st-256color" ] ; then
    export TERM=xterm-256color
fi

###############################################################################
# Aliases
################################################################################

alias cls="clear"

alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -alF"

alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto"

alias gll="git log --all --graph --decorate"
alias gl="gll --oneline"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gdc="git diff --cached"
alias glu="git ls-files --others --exclude-standard"
alias gf="git fetch"

alias sv="sudo vim"
alias v="vim"
alias sr="sudo ranger"
alias r="ranger"
alias clip="xclip -selection clipboard"

alias pacman="pacman --color=auto"
alias yay="yay --color=auto"
alias pacaur="pacaur --color=auto"

################################################################################
# Colors
################################################################################

   COLOR_NONE="\[\e[0m\]"
        BLACK="\[\e[0;30m\]"
    DARK_GRAY="\[\e[1;30m\]"
          RED="\[\e[0;31m\]"
    LIGHT_RED="\[\e[1;31m\]"
        GREEN="\[\e[0;32m\]"
  LIGHT_GREEN="\[\e[1;32m\]"
       YELLOW="\[\e[0;33m\]"
 LIGHT_YELLOW="\[\e[1;33m\]"
         BLUE="\[\e[0;34m\]"
   LIGHT_BLUE="\[\e[1;34m\]"
      MAGENTA="\[\e[0;35m\]"
LIGHT_MAGENTA="\[\e[1;35m\]"
         CYAN="\[\e[0;36m\]"
   LIGHT_CYAN="\[\e[1;36m\]"
   LIGHT_GRAY="\[\e[0;37m\]"
        WHITE="\[\e[1;37m\]"

################################################################################
# Prompt
################################################################################

function set_git_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [[ "$branch" =~ ^([A-Z]*-[0-9]*)-.* ]] ; then
        branch="${BASH_REMATCH[1]}"
    fi
    status=`git status 2> /dev/null`
    if [ -z "$branch" ] ; then
        BRANCH=""
    elif [[ $(echo ${status} | grep "nothing to commit") ]] ; then
        BRANCH="${WHITE}(${branch})${COLOR_NONE}"
    elif [[ $(echo ${status} | grep "nothing added to commit but untracked files present") ]] ; then
        BRANCH="${LIGHT_YELLOW}(${branch})${COLOR_NONE}"
    else
        BRANCH="${LIGHT_RED}(${branch})${COLOR_NONE}"
    fi
}

function set_prompt_symbol() {
    if [ $1 -eq 0 ] ; then
        PROMPT_SYMBOL="\$"
    else
        PROMPT_SYMBOL="${RED}\$${COLOR_NONE}"
    fi
}

function set_virtualenv() {
    if [ -z "$VIRTUAL_ENV" ] ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${LIGHT_MAGENTA}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
    fi
}

# Set the full bash prompt.
function set_bash_prompt() {
    set_prompt_symbol $?
    set_virtualenv
    set_git_branch
    PS1="${PYTHON_VIRTUALENV}${LIGHT_GREEN}\u@\h${COLOR_NONE}:${LIGHT_BLUE}\W${COLOR_NONE}${BRANCH}${PROMPT_SYMBOL} "
}

# Set prompt and terminal title
PROMPT_COMMAND='set_bash_prompt ; echo -ne "\033]0;${PWD/#$HOME/\~} - Terminal\a"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
