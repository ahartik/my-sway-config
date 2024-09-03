#!/bin/bash

original_dir="$(pwd)"

$HOME/.config/sway/screenshot.sh

# -p is for the swaylock-fprintd-git package
# TODO: Debug why this doesn't work
# swaylock -p --image /tmp/lock/blurred.jpg
swaylock --image /tmp/lock/blurred.jpg
