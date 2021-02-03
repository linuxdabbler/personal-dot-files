#!/bin/bash

weather=$(cat ~/.config/weather.txt | sed 20q | grep value | awk '{print $2 $3}' | sed 's/\"//g')

temp=$(cat ~/.config/weather.txt | grep temp_F | awk '{print $2}' | sed 's/\"//g' | sed 's/,//')

nocloud="盛"
cloud=""
rain=""
storm=""
lotempicon=""
midtempicon=""
hitempicon=""

#print weather info
TEMP() {
if [ "$temp" -gt 80 ]; then
	echo -e $hitempicon $temp
elif [ "$temp" -ge 50 ] && [ "$temp" -le 79 ]; then
	echo -e $midtempicon $temp
elif [ "$temp" -le 49]; then
	echo -e $lotempicon $temp
fi
}

WEATHER () {
if [[ "$weather" = "Clear" ]] || [[ "$weather" = "Sunny" ]]; then
	echo -e "$nocloud $weather"
else
	echo -e "$cloud $weather"
fi
}

echo $(WEATHER) $(TEMP)
