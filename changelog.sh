#!/bin/sh
SOURCESDIR=/opt
PROJECT_NAME=JambulaTV
PROJECT_BASE_DIR=$SOURCESDIR/$PROJECT_NAME

ACTION=$1
SPECIFIED_FROM_TAGGED_VERSION=$2
SPECIFIED_TO_TAGGED_VERSION=$3
LAST_TAGGED_VERSION=$(git describe --tags --abbrev=0)



# Change to git directory
#cd $PROJECT_BASE_DIR

case $ACTION in
since-last-version)
# Changes from Last tagged version up to current HEAD
git log --decorate ${LAST_TAGGED_VERSION}..HEAD
;;

since-specific-version)
if [[ "x$SPECIFIED_FROM_TAGGED_VERSION" = "x" ]];
then
clear
cat <<EOF
Usage: $(basename $0) $ACTION [LAST VERSION]
EOF
exit 1
fi

# changes since specified-from-tag to current HEAD
cat <<ET

Changes since ${SPECIFIED_FROM_TAGGED_VERSION}
--------------------

ET
git log --reverse --abbrev-commit --pretty=tformat:"* %s %n" ${SPECIFIED_FROM_TAGGED_VERSION}..HEAD | sed "s:      : :g"
;;

between-specific-versions)
if [[ "x$SPECIFIED_FROM_TAGGED_VERSION" = "x" || "x$SPECIFIED_TO_TAGGED_VERSION" = "x" ]];
then
clear
cat <<EOF
Usage: $(basename $0) $ACTION [FROM VERSION] [TO VERSION]
EOF
exit 1
fi

# changes since specified-from-tag to specified-to-tag
git log --reverse --abbrev-commit --pretty=tformat:"* %s %n" ${SPECIFIED_FROM_TAGGED_VERSION}..${SPECIFIED_TO_TAGGED_VERSION} | sed "s:      : :g"
;;

*)
clear
cat <<EOF
Usage: $(basename $0) [ since-last-version | since-specific-version | between-specific-versions ]
EOF
exit 1
;;
esac
