#!/bin/sh
~/.fehbg
xset r rate 250 30
setxkbmap -layout us,ru,ua -option grp:alt_shift_toggle
picom -b
nm-applet &
xss-lock -- betterlockscreen -l blur &
