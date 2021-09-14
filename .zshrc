autoload -U colors && colors
setopt autocd
stty stop undef
setopt interactive_comments

setopt hist_ignore_space
setopt hist_ignore_dups
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
HISTFILE=~/.cache/zsh/history

autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit -d ~/.cache/zsh/compdump-$ZSH_VERSION
_comp_options+=(globdots)

bindkey -e
export KEYTIMEOUT=1

bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -a "^[[1;5C" forward-word
bindkey -a "^[[1;5D" backward-word

[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

[ -f ~/.config/aliasrc.sh ] && . ~/.config/aliasrc.sh
[ -f ~/.config/shell_prompt_utils.sh ] && . ~/.config/shell_prompt_utils.sh

precmd() {
    set_docker
    set_virtualenv
    set_git_branch
    PS1="${DOCKER}${PYTHON_VIRTUALENV}%B%F{green}%n@%m%f%b:%B%F{blue}%1~%f%b${BRANCH}%(?.$.%F{red}$%f) "
    echo -ne "\033]0;${PWD/#$HOME/~} - Terminal\a"
}

vimsed() {
    local prefix
    if [ ! -t 0 ]; then prefix="cat -"; else prefix="echo"; fi
    sh -c $prefix | vim -E +"execute \"normal! $@\"" +%p +q! /dev/stdin
}

# should be last
. /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
