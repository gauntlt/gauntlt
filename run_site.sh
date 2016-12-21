#!/bin/bash

# verify that Gruyere is running
if ps aux | grep -q "[g]ruyere"; then
	echo "Gruyere already running..."
else
	echo "Launching Gruyere..."
	cd ./vendor/gruyere/
	source manual_launch.sh
	sleep 5s
fi

export FORM_URL=$(curl -is 127.0.0.1:8008 | grep "Location" \
	| cut -d ' ' -f 2 | tr -d '//' | tr -d '\r\n'); echo "Gruyere URL = $FORM_URL";
