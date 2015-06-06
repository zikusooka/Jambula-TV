#!/bin/sh

# Add entries to exports files
echo "# /JambulaTV
/JambulaTV	*(rw,async)
" >> /etc/exports

# Enable systemd startup at boot
systemctl enable nfs-server.service
systemctl start nfs-server.service
