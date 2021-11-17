#!/bin/sh

export DISPLAY=:0

setxkbmap -layout \\"us,ru,ua\\" -option 'grp:alt_shift_toggle'
xset r rate 250 30
