#!/bin/bash
lscpu | grep MHz -m1 | awk '{printf "%.2f GHz", $NF/1000}'
