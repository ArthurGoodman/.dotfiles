#!/bin/sh

load=$(cat ~/.local/share/lf/files)
mode=$(echo "$load" | sed -n '1p')
list=$(echo "$load" | sed '1d' | tr ' ' '*')
if [ $mode = 'copy' ]; then
    rsync -HAXauvP $list ./
    rm ~/.local/share/lf/files
    lf -remote 'send clear'
fi
