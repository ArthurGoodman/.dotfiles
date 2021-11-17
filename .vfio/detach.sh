#!/bin/sh
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
sudo virsh detach-device win10 $DIR/keyboard.xml
sudo virsh detach-device win10 $DIR/mouse.xml
$HOME/.keyboard_config.sh
