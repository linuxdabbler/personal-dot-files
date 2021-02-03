#!/bin/sh
#relies on curl
#recommend putting this script in a cron job that runs at least once a day.
curl wttr.in/Tuscaloosa?format=j1 | sed 30q > ~/.config/weather.txt
