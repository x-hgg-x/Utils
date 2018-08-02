#!/bin/bash
declare -x DISPLAY=":0.0"
wmctrl -lx | grep nemo.Nemo | sed -e 's/Dossier\ personnel/ - ./; s/Corbeille/ - trash:/' | awk -F' - ' '{print $2}' > ~/nemo.dat
