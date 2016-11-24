#!/bin/bash
MAXTEMP=80

. ~/Boinc/boinc_funcs.sh

MAXFANS=0

function BNCsus {
	boinc_proj_suspend
	sleep $1
	boinc_proj_resume
}

while true; do
	TEMP=$(nvidia-smi -q -d TEMPERATURE |  grep "GPU Current Temp" | cut -d':' -f 2 | cut -d' ' -f 2) 

	if [[ $TEMP -gt $MAXTEMP ]]; then 
		echo "Temperature $TEMP is above Allowed setting of $MAXTEMP Degrees.";
		if [[ $MAXFANS -ne 0 ]]; then
			echo "Fans are already at maximum, suspending execution for 5 mins"
			sleep 2
			BNCsus 5m
		else
			echo "Setting fans to max speed, and suspending execution for 1 min"
			/etc/init.d/fancontrol stop
			BNCsus 1m
			MAXFANS=1
		fi
	else
		echo "Temperature $TEMP is ok, sleeping..."
		sleep 5m; 
	fi
	if [[ $TEMP -gt 95 ]]; then
		halt
	fi
done
