#!/bin/bash

ICON_BATTERY_FULL=""
ICON_BATTERY_75=""
ICON_BATTERY_HALF=""
ICON_BATTERY_25=""
ICON_BATTERY_LOW=""
ICON_PLUG=""

print_battery()  {
	icon=""
	if [ -f /tmp/BAT0/POWER ]; then
		battery_percent="$(cat /tmp/BAT0/POWER)"
		battery_charge="$(cat /tmp/BAT0/CHARGING)"
		if [ "$battery_percent" -gt 90 ]; then
			icon="$ICON_BATTERY_FULL"
		elif [ "$battery_percent" -gt 60 ]; then
			icon="$ICON_BATTERY_75"
		elif [ "$battery_percent" -gt 30 ]; then
			icon="$ICON_BATTERY_HALF"
		elif [ "$battery_percent" -gt 5 ]; then
			icon="$ICON_BATTERY_25"
		else
			icon="$ICON_BATTERY_LOW"
		fi
		if [[ "$battery_charge" = "true" ]]; then
			echo "$icon $battery_percent% $ICON_PLUG"
		else
			echo "$icon $battery_percent%"
		fi
	else
		echo ""
	fi
}


trap exit INT
trap "echo" USR1


while true; do
	print_battery "$@"
	
	sleep 5 &
	wait
done
