#!/bin/bash
#

original_dir="$(pwd)"

mkdir -p /tmp/lock
cd /tmp/lock

grim -t jpeg screen.jpg

rm -f blurred.jpg 
ffmpeg -i screen.jpg -vf 'gblur=sigma=20' blurred.jpg

swaylock --image blurred.jpg
