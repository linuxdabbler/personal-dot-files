#!/bin/bash
# icons depend on nerdfonts being installed
bat() {
	batstat="$(cat /sys/class/power_supply/BAT0/status)"
	battery="$(cat /sys/class/power_supply/BAT0/capacity)"
	    if [[ $batstat = 'Unknown' ]] || [[ $batstat = 'Charging' ]]; then
	    batstat=""
	    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
	    batstat=""
	    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
	    batstat=""
	    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
	    batstat=""
	    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
	    batstat=""
	    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
	    batstat=""
	    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
	    batstat=""
	    fi

	    echo "$batstat  $battery %"
}

echo "$(bat)"
