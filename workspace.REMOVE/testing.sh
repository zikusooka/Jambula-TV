#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################
patch -p1 $COOVA_CONFIG_DIR/functions < $PROJECT_PATCHES_DIR/coova_functions.patch

exit


uninstall_freepbx


freepbx_preinstall


freepbx_install

