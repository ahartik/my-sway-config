#!/bin/bash

swaymsg input type:keyboard xkb_switch_layout next

LAYOUT=$(swaymsg -r -t get_inputs | jq -r 'first(.[]|.xkb_active_layout_name | select (.!=null))')

swayosd-client --custom-icon input-keyboard --custom-message "$LAYOUT"
