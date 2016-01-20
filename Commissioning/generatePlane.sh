#!/bin/bash

xmin=30
xmax=638

ymin=0
ymax=375

zsafe=70
#zwork=$zsafe
zwork=64.5

#Slightly less than twice cutter diameter.
yincrement=5

#mm/min
workfeed=600

echo "G28"
echo "G0 X$xmin Y$ymin Z$zsafe F6000"
echo "G0 Z$zwork F100"

ytwoWayIncrement=$(echo "$yincrement * 2" | bc)
for i in `seq $ymin $ytwoWayIncrement $ymax`;
do
	halfPass=$(echo "$i + $yincrement" | bc)
	echo "G0 X$xmin Y$i F$workfeed"
	echo "G0 X$xmax Y$i F$workfeed"
	
	echo "G0 X$xmax Y$halfPass F$workfeed"
	echo "G0 X$xmin Y$halfPass F$workfeed"
done 
