WM_NAME=win10

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

attach_device() {
    dev=$(basename -s .xml $1)
    echo "Attaching $dev..."

    sudo virsh attach-device $WM_NAME "$DIR/$dev.xml"
}

detach_device() {
    dev=$(basename -s .xml $1)
    echo "Detaching $dev..."

    sudo virsh detach-device $WM_NAME "$DIR/$dev.xml"

    if [ $dev = keyboard ]; then
        $HOME/.keyboard_config.sh
    fi
}
