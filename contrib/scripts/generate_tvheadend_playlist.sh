#!/bin/sh
# Generate TV Channels playlist from Tvheadend
#NETWORK_IP_ADDRESS=192.168.0.251
NETWORK_IP_ADDRESS=172.16.0.1
TVHEADEND_PORT=9981
PLAYLISTS_DIR=/JambulaTV/Playlists


lynx -dump http://$NETWORK_IP_ADDRESS:$TVHEADEND_PORT/playlist/channels
