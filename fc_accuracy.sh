#!/bin/bash
# Extract the forecasted and observed temperatures for today and store them in variables
yesterday_fc=$(tail -2 rx_poc.log | head -1 | grep -oE '[0-9]+' | head -1)

#Calculate the forecast accuracy
today_temp=$(tail -1 rx_poc.log | grep -oE '[0-9]+' | head -1)
accuracy=$(($yesterday_fc-$today_temp))
echo "accuracy is $accuracy"

# Assign a label to each forecast based on its accuracy
if (( accuracy >= -1 && accuracy <= 1 ))
then
    accuracy_range=excellent
elif (( accuracy >= -2 && accuracy <= 2 ))
then
    accuracy_range=good
elif (( accuracy >= -3 && accuracy <= 3 ))
then
    accuracy_range=fair
else
    accuracy_range=poor
fi
echo "Forecast accuracy is $accuracy and $accuracy_range"

# Append a record to your historical forecast accuracy file
row=$(tail -1 rx_poc.log)
year=$( echo $row | cut -d " " -f1)
month=$( echo $row | cut -d " " -f2)
day=$( echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv

