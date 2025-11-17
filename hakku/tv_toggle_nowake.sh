#!/bin/bash

display_tv='LG Electronics LG TV SSCR2 0x01010101'
display_wide='BNQ BenQ EX3501R K4L00234019'

IS_ENABLED=$(swaymsg -t get_outputs | jq 'map (select(.model=="LG TV SSCR2").active)[0]')
echo IS_ENABLED=$IS_ENABLED

# Also set sound output to HDMI
SPEAKER_SINK="alsa_output.usb-Vanatoo_Vanatoo_T0-00.analog-stereo"

if [[ "$IS_ENABLED" == 'true' ]]; then
	echo "TV is on, disabling"
	swaymsg "output '$display_tv' disable"
  swaymsg "output '$display_wide' position 0 0"
	pactl set-default-sink "$SPEAKER_SINK"
else
	echo "TV is off, switching on"
	swaymsg "output '$display_tv' enable"
  swaymsg "output '$display_tv' position 0 0"
  swaymsg "output '$display_wide' position 3840 0"
	# $HOME/.config/sway/hakku/lgtv --name OLEDG4 on &
	# bash -c "sleep 1 && $HOME/.config/sway/hakku/lgtv --name OLEDG4 --ssl setInput HDMI_3 " &
	# swaymsg "output '$display_tv' power on"
  # TODO: Figure out why HDMI sink changes names.
  sleep 0.5
  HDMI_SINK=$(pactl -f json list sinks | jq -r '.[].name | select(. | contains("hdmi"))')
  echo HDMI_SINK=$HDMI_SINK

	pactl set-default-sink "$HDMI_SINK"
fi
