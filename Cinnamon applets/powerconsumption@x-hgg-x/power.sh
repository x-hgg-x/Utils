#!/bin/bash
echo "$(cat /sys/class/power_supply/BAT0/current_now) * $(cat /sys/class/power_supply/BAT0/voltage_now) / 1000000000000 " | bc -l | awk '{printf " %.1f W ", $1}'
