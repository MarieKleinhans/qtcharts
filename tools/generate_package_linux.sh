#!/bin/sh

CHARTS_TEMP_DIR=temp_dir
CHARTS_TEMP_DIR_FULL=../$CHARTS_TEMP_DIR

if [ "$1" = "" ]
then
    echo Usage: $0 version [branch or SHA]
    echo Branch defaults to master.
    echo Creates the package in parent dir.
    echo A temporary dir $CHARTS_TEMP_DIR_FULL is utilized for intermediate steps.
fi

if [ "$2" = "" ]
then
    CHARTS_BRANCH=origin/master
else
    CHARTS_BRANCH=$2
fi

CHARTS_VERSION=$1
CHARTS_CURRENT_DIR=$PWD
CHARTS_BUILD_DIR=$CHARTS_TEMP_DIR_FULL/tempbuild
CHARTS_PACKAGE_UNTAR_NAME=qtcharts-$CHARTS_VERSION
CHARTS_PACKAGE_UNTAR_DIR=$CHARTS_TEMP_DIR_FULL/$CHARTS_PACKAGE_UNTAR_NAME
CHARTS_TEMP_TAR=qtcharts_temp_$CHARTS_VERSION.tar
CHARTS_TEMP_TAR_FULL=$CHARTS_TEMP_DIR_FULL/$CHARTS_TEMP_TAR
CHARTS_FINAL_TAR=$CHARTS_CURRENT_DIR/../qt-enterprise-charts-src-$CHARTS_VERSION.tar

echo Exporting $CHARTS_BRANCH to $CHARTS_TEMP_TAR_FULL...
rm -r -f $CHARTS_TEMP_DIR_FULL 2> /dev/null
mkdir -p $CHARTS_TEMP_DIR_FULL 2> /dev/null
git fetch
git archive --format tar --output $CHARTS_TEMP_TAR_FULL $CHARTS_BRANCH

echo Unpacking $CHARTS_TEMP_TAR_FULL to $CHARTS_PACKAGE_UNTAR_DIR and $CHARTS_BUILD_DIR...
mkdir -p $CHARTS_PACKAGE_UNTAR_DIR 2> /dev/null
mkdir -p $CHARTS_BUILD_DIR 2> /dev/null
tar -xvf $CHARTS_TEMP_TAR_FULL -C $CHARTS_PACKAGE_UNTAR_DIR > /dev/null
tar -xvf $CHARTS_TEMP_TAR_FULL -C $CHARTS_BUILD_DIR > /dev/null
#Workaround for git archive bug
rm -r -f $CHARTS_PACKAGE_UNTAR_DIR/tools
rm -r -f $CHARTS_PACKAGE_UNTAR_DIR/tests
rm -r -f $CHARTS_BUILD_DIR/tools
rm -r -f $CHARTS_BUILD_DIR/tests

echo Generating includes, mkspecs, and docs in $CHARTS_BUILD_DIR...
cd $CHARTS_BUILD_DIR
mkdir -p .git 2> /dev/null
qmake > /dev/null 2> /dev/null
make docs > /dev/null 2> /dev/null
cd $CHARTS_CURRENT_DIR

echo Copying generated files to $CHARTS_PACKAGE_UNTAR_DIR
cp -r $CHARTS_BUILD_DIR/doc/qch $CHARTS_PACKAGE_UNTAR_DIR/doc/qch
cp -r $CHARTS_BUILD_DIR/doc/html $CHARTS_PACKAGE_UNTAR_DIR/doc/html

echo Repackaging $CHARTS_PACKAGE_UNTAR_DIR to $CHARTS_FINAL_TAR
rm $CHARTS_FINAL_TAR 2> /dev/null
cd $CHARTS_TEMP_DIR_FULL
tar -cvf $CHARTS_FINAL_TAR $CHARTS_PACKAGE_UNTAR_NAME >/dev/null
gzip $CHARTS_FINAL_TAR >/dev/null
cd $CHARTS_CURRENT_DIR

exit 0