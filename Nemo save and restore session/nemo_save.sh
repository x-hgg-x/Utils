#!/bin/bash
declare -x DISPLAY=":0.0"
sleep 15
wmctrl -lx | grep nemo.Nemo && wmctrl -lx | grep nemo.Nemo | sed -e "s#Dossier\ personnel# - $HOME#" | awk -F' - /' '{print "/"$2}' > ~/nemo.dat
