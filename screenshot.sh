#!/bin/bash
/
# Adapted from
# https://gist.github.com/singulared/7c6d53c1b84fbb7cf22d07c5c7d3e945

CORRUPTER_BIN=$HOME/local/bin/corrupter

original_dir="$(pwd)"

make_screenshot() {
OUTPUT=$1
    IMAGE=/tmp/lock/$OUTPUT-lock.jpg
    time grim -o $OUTPUT $IMAGE
    BLURRED_IMAGE=/tmp/lock/$OUTPUT-blurred.jpg
    rm -f $BLURRED_IMAGE
    time $CORRUPTER_BIN -mag 20 $IMAGE $BLURRED_IMAGE 
}

mkdir -p /tmp/lock
for OUTPUT in `swaymsg -t get_outputs | jq -r '.[].name'`
do
  make_screenshot $OUTPUT &
    # time ffmpeg -i $IMAGE -vf 'gblur=sigma=20' $BLURRED_IMAGE
done
wait
