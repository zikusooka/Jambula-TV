#!/usr/bin/env bash
template=$(cat <<TEMPLATE
$SERVICEOUTPUT

TEMPLATE
)

/usr/bin/jambulatv-osd -m "$template"
