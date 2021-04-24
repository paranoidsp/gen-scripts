#!/bin/bash

function batCapacity()   {
  bat1=$(cat /sys/class/power_supply/BAT1/energy_now)
  bat1_full=$(cat /sys/class/power_supply/BAT1/energy_full)

  bat0=$(cat /sys/class/power_supply/BAT0/energy_now)
  bat0_full=$(cat /sys/class/power_supply/BAT0/energy_full)

  echo "scale=2;($bat0 + $bat1)/($bat0_full + $bat1_full)" | bc -l
}
echo -n "$(date +"%Y-%m-%dT%H:%M:%S")   "
batCapacity
