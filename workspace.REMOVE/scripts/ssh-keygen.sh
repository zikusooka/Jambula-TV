#!/bin/sh
AUTOLOGIN_USER=root
AUTOLOGIN_USER_HOME_DIR=`finger $AUTOLOGIN_USER | grep Directory: | awk {'print $2'}`
clear



# Add ssh key for passwordless logins at remote servers
ssh-keygen -t rsa -N "" -f $AUTOLOGIN_USER_HOME_DIR/.ssh/id_rsa


