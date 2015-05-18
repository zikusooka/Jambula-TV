#!/usr/bin/env bash
template=$(cat <<TEMPLATE
$HOSTALIAS:
$NOTIFICATIONTYPE
$SERVICEDESC
$SERVICESTATE
$SERVICEOUTPUT
$LONGDATETIME

TEMPLATE
)

/usr/bin/gcsms -c /var/spool/icinga2/.gcsms send aex-alerts "$template"
