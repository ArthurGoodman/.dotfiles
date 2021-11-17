#!/bin/sh
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
sudo virsh attach-device win10 $DIR/keyboard.xml
sudo virsh attach-device win10 $DIR/mouse.xml
