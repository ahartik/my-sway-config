#!/bin/bash
if grep -q Discharging /sys/class/power_supply/BAT0/status
then
  echo "on battery, suspending"
  systemctl suspend
else
  echo "on DC, not suspending"
fi
