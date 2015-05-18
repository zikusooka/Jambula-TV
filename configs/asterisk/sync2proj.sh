#!/bin/sh
clear

rsync -avz --delete /etc/JambulaTV/asterisk/ /JambulaTV/RELEASE-2.0/configs/asterisk/
