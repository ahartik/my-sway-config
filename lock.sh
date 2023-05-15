#!/bin/bash

original_dir="$(pwd)"

$HOME/.config/sway/screenshot.sh

swaylock --image /tmp/lock/blurred.jpg
