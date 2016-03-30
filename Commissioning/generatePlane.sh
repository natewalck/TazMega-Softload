#!/bin/bash

xmin=0
xmax=425

ymin=0
ymax=315

zsafe=50
#zwork=$zsafe
zwork=15

#Slightly less than half cutter diameter.
yincrement=5

#mm/min
workfeed=600

echo "M106 P1 S255"				#Fan on.
echo "G28"					
echo "T5"					#Switch to CNC mill tool.
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
