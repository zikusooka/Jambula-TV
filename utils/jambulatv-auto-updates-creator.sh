#!/bin/sh
clear
JAMBULATV_NEW_VERSION=$1
JAMBULATV_UPDATES_DIR=/tmp/freshly-baked-updates # Add path from somewhere in git tree
JAMBULATV_FTP_SERVER_HOST=jlabs2
JAMBULATV_FTP_SERVER_UPDATES_DIR=/home/vhosts/jambula/FTP/JambulaTV/updates
WORK_DIR=/tmp




# help Manual
if [ "x$1" = "x" ]
then
echo "Usage:  ./`basename $0` [UPDATE VERSION e.g. 3.9]
"
exit 1
fi

# Change to work directory
cd $WORK_DIR
# Create tarball
tar zcvf update-$JAMBULATV_NEW_VERSION.tar.gz update-$JAMBULATV_NEW_VERSION 

# Create checksum
openssl dgst -md5 $WORK_DIR/update-$JAMBULATV_NEW_VERSION.tar.gz | cut -d "=" -f2 |sed -e "s/ //" > $WORK_DIR/update-$JAMBULATV_NEW_VERSION.checksum.txt


# Create updates directory if this is first time
[ -d $JAMBULATV_UPDATES_DIR ] || mkdir -p $JAMBULATV_UPDATES_DIR

# Move to updates package directory
mv -v $WORK_DIR/update-* $JAMBULATV_UPDATES_DIR

# Copy/Sync to FTP server
rsync -avz $JAMBULATV_UPDATES_DIR/ $JAMBULATV_FTP_SERVER_HOST:$JAMBULATV_FTP_SERVER_UPDATES_DIR/
