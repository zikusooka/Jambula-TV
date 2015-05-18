#!/usr/bin/env bash
template=$(cat <<TEMPLATE

$SERVICESTATE
$SERVICEOUTPUT

TEMPLATE
)

sudo /usr/bin/jambulatv-connect-2-wifi-ap $SERVICESTATE
