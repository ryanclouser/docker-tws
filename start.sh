#!/bin/bash
Jts/*/tws $ARGS &
if grep -q 'tradingMode=p' Jts/jts.ini
then
	sleep 60
	xte 'key Return'
fi
wait
