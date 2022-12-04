#!/bin/bash

swayidle timeout 310 "~/.config/sway/lock.sh" \
  timeout 300 'swaymsg "output * dpms off"' \
  timeout 600 '$HOME/.config/sway/suspend_if_battery.sh' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "~/.config/sway/lock.sh" &
