#!/bin/bash

set -x

HDMI_SINK=$(pactl -f json list sinks | jq -r '.[].name | select(. | contains("hdmi"))')

SINKS=(
  alsa_output.usb-Vanatoo_Vanatoo_T0-00.analog-stereo
  alsa_output.usb-Generic_USB_Audio-00.HiFi__Headphones__sink
  $HDMI_SINK
)

CURRENT_SINK=$(pactl get-default-sink)

IDX=-1
for i in "${!SINKS[@]}"; do
   if [[ "${SINKS[$i]}" = "$CURRENT_SINK" ]]; then
     IDX=${i}
   fi
done

for try_number in $(seq ${#SINKS[@]})
do

NEXT_IDX=$(( ($IDX + 1) % ${#SINKS[@]} ))

NEXT_SINK=${SINKS[$NEXT_IDX]}
echo IDX=$IDX NEXT_IDX=$NEXT_IDX NEXT_SINK=$NEXT_SINK

pactl set-default-sink "$NEXT_SINK"

CURRENT_SINK=$(pactl get-default-sink)
if [[ "$CURRENT_SINK" == "$NEXT_SINK" ]]
then
  break
else
  echo "failed to switch, trying next"
fi

IDX=$NEXT_IDX

done
