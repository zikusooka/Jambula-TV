#!/usr/bin/env bash
template=$(cat <<TEMPLATE

$SERVICESTATE
$SERVICEOUTPUT

TEMPLATE
)

sudo /usr/bin/jambulatv-presence-detection $SERVICESTATE
