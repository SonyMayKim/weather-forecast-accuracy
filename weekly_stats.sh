#!/bin/bash

tail -7 synthetic_historical_fc_accuracy.tsv | cut -f6 > scratch.txt

week_fc=($(cat scratch.txt))

# validate the result
for i in "${week_fc[@]}"; do
	echo $i
done

# Display the minimum and maximum absolute forecasting errors for the week
for i in "${week_fc[@]}"; do
	if (( week_fc[i]  < 0 ))
	then
		week_fc[i]=$(( -week_fc[i] ))
	fi
done
#printing absolute values
echo "absolute values:"
for i in "${week_fc[@]}"; do
        echo $i
done


minimum=${week_fc[0]}
maximum=${week_fc[0]}
for item in "${week_fc[@]}"; do
	if (( item < minimum ))
	then
		minimum=$item
	fi
	if (( item > maximum ))
	then
		maximum=$item
	fi
done

echo "minimum absolute error = $minimum"
echo "maximum absolute error = $maximum"

