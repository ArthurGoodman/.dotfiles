alias ls="ls --color=auto --group-directories-first"
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

alias conf="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias confl="conf log --all --graph --decorate --oneline"
alias confs="conf status"
alias confd="conf diff"
alias confdc="conf diff --cached"

alias v="vim"
alias sv="sudo vim"
alias p="pacman"
alias sp="sudo pacman"
alias clip="xclip -selection clipboard"

alias pacman="pacman --color=auto"
alias yay="yay --color=auto"
alias pacaur="pacaur --color=auto"

alias make="ARGS=-j16 make -j16 --no-print-directory"
alias ctest="ctest -j16"
alias pm="pulsemixer"

alias rs="repo status"
alias rd="repo diff"
