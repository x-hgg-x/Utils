#!/bin/bash
IFS=$'\n'; read -d '' -r -a dirs < ~/nemo.dat; nemo "${dirs[@]}"
