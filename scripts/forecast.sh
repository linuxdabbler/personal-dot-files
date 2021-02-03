#!/bin/bash

weather() {
    wthr="$(sed 20q ~/.config/weather.txt | grep value | awk '{print $2 $3}' | sed 's/"//g')"
    echo " $wthr"
}

## TEMP
temp() {
    tmp="$(grep temp_F ~/.config/weather.txt | awk '{print $2}' | sed 's/"//g' | sed 's/,/ F/g')"
    echo " $tmp"
}

echo "$(weather) $(temp)"


