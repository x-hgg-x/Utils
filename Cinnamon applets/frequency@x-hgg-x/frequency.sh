#!/bin/bash
lscpu --all --extended | tail -n+2 | awk '{x+=$NF; next} END {printf "%.2f GHz", x/NR/1000}'
