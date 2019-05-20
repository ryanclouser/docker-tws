#!/bin/bash
Jts/*/tws $ARGS &
if grep -q 'tradingMode=p' Jts/jts.ini
then
	sleep 15
	xte 'key Return'
fi
wait
