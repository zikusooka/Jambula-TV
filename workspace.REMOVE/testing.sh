#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################
#ASTERISK_FILES_USER=root #asterisk #nginx
uninstall_freepbx


freepbx_preinstall


freepbx_install

