#!/bin/bash
sleep 2
IFS=$'\n'; read -d '' -r -a dirs < ~/nemo.dat; nemo "${dirs[@]}"
