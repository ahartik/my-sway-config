#!/bin/bash

if [[ $1 == "--screenshot" ]]
then
$HOME/.config/sway/screenshot.sh
fi

# PHYSICS TIME
# swaylock --image $HOME/memes/second_quantization.png
# exit 

# -p is for the swaylock-fprintd-git package
# TODO: Debug why this doesn't work
# swaylock -p --image /tmp/lock/blurred.jpg
LOCKARGS=

# See screenshot.sh which takes these screenshots
for OUTPUT in $(swaymsg -t get_outputs | jq -r '.[].name')
do
    BLURRED_IMAGE=/tmp/lock/$OUTPUT-blurred.jpg
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${BLURRED_IMAGE}"
done

swaylock $LOCKARGS


