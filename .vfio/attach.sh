#!/bin/sh

DEVICES=$@

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

. $DIR/common.sh

if [ -z "$DEVICES" ]; then
    for file in $(ls $DIR/*.xml); do
        attach_device $file
    done
else
    for dev in $DEVICES; do
        attach_device $dev
    done
fi
