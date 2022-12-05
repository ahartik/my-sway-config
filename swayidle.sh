#!/bin/bash

swayidle timeout 310 "~/.config/sway/lock.sh" \
  timeout 300 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  timeout 600 '$HOME/.config/sway/suspend_if_battery.sh' \
  before-sleep "~/.config/sway/lock.sh" \
  after-resume 'swaymsg "output * dpms on"' &
