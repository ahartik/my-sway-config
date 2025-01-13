#!/bin/bash

SINKS=(
  alsa_output.usb-Vanatoo_Vanatoo_T0-00.analog-stereo
  alsa_output.usb-Generic_USB_Audio-00.HiFi__Headphones__sink
  alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
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
if pactl set-default-sink $NEXT_SINK
then
  break
fi

IDX=$NEXT_IDX

done
