#!/bin/sh
PROJECT_NAME=JambulaTV
SOURCESDIR=/opt
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

# Source functions file
. $PROJECT_BASE_DIR/functions



#################
#  MAIN SCRIPT  #
#################
# Patch logn-config.sh
patch -p1 $COOVA_HTML_DIR/www/config-local.sh < $PROJECT_PATCHES_DIR/coova_login_config_local.patch  

# patch login.chi: Redirect to customized Jambula Splash Web Pages
patch -p1 $COOVA_HTML_DIR/www/login.chi < $PROJECT_PATCHES_DIR/coova_login_chi.patch
#
#
