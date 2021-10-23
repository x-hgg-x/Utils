#!/bin/bash
sleep 2
IFS=$'\n'; read -d '' -r -a dirs < ~/nemo.dat

for dir in "${dirs[@]}"; do
    nemo "$dir" &
    sleep 0.5
done
