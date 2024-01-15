#!/bin/bash

/opt/asic-hub/hub -c /etc/asic-hub/config.toml &
pid=$!

sleep 3

if [ -n "${FARM_HASH}" ]; then
	/opt/asic-hub/hubctl register $FARM_HASH
fi

wait "$pid"
ret=$?

echo "ASIC hub exited with code: $ret"
