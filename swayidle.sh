#!/bin/bash

killall -w swayidle

swayidle  \
  timeout 299 "~/.config/sway/screenshot.sh" \
  timeout 310 "~/.config/sway/lock.sh" \
  timeout 300 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  timeout 600 '$HOME/.config/sway/suspend_if_battery.sh' \
  before-sleep "~/.config/sway/lock.sh --screenshot" \
  after-resume 'swaymsg "output * dpms on"' &
