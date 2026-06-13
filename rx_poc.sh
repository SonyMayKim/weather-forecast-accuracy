#!/bin/bash

#Assign the city name to Casablanca for accessing the weather report
city=Casablanca

#Obtain the weather information for Casablanca
curl -s wttr.in/$city?T --output weather_report

#Extract the current temperature, and store it in a shell variable called obs_temp
obs_temp=$(curl -s wttr.in/$city?T | grep -oE '[0-9]+' | head -1)
echo "The current Temperature of $city: $obs_temp C"

#Extract tomorrow's temperature forecast for noon, and store it in a shell variable called fc_temp
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep -oE '[0-9]+' | head -1)
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"

#Assign Country and City to variable TZ
TZ='Morocco/Casablanca'

# Use command substitution to store the current day, month, and year in corresponding shell variables:
day=$(TZ='Morocco/Casablanca' date -u +%d)
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

#Merge the fields into a tab-delimited record
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo "$record">>rx_poc.log

