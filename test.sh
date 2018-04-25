#!/bin/sh

set -e

if [ -z "$TESTDIR" ]; then
	TESTDIR=testdir
fi

INFILES="GOPR0001.MP4
GOPR0002.MP4
GOPR0003.MP4
GP010001.MP4
GP010002.MP4
GP020001.MP4
NOTGOPRO.MP4"

OUTFILES="GoPro_0001_00.MP4
GoPro_0001_01.MP4
GoPro_0001_02.MP4
GoPro_0002_00.MP4
GoPro_0002_01.MP4
GoPro_0003_00.MP4
NOTGOPRO.MP4"

OUTFILES_WITH_PREFIX="AAA0001_00.MP4
AAA0001_01.MP4
AAA0001_02.MP4
AAA0002_00.MP4
AAA0002_01.MP4
AAA0003_00.MP4
NOTGOPRO.MP4"

cleanup() {
	rm -rf $1
}

init() {
	rm -rf $1
	mkdir -p $1
	for f in $INFILES; do
		touch $1/$f
	done
}

echo "===> work on files"
init $TESTDIR
./gopro-rename -v $TESTDIR/*
if [ "$(ls $TESTDIR)" = "$OUTFILES" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> work on dirs"
init $TESTDIR
./gopro-rename -v $TESTDIR
if [ "$(ls $TESTDIR)" = "$OUTFILES" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> dry-run mode"
init $TESTDIR
./gopro-rename -n $TESTDIR
if [ "$(ls $TESTDIR)" = "$INFILES" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> non-recursive"
init $TESTDIR/subdir
./gopro-rename -v $TESTDIR
if [ "$(ls $TESTDIR/subdir)" = "$INFILES" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> recursive"
init $TESTDIR/subdir
./gopro-rename -vr $TESTDIR
if [ "$(ls $TESTDIR/subdir)" = "$OUTFILES" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> safety"
init $TESTDIR
touch $TESTDIR/GoPro_0001_01.MP4
if ./gopro-rename $TESTDIR; then
	echo Failed
	exit 1
else
	echo OK
fi
cleanup $TESTDIR

echo "===> force"
init $TESTDIR
touch $TESTDIR/GoPro_0001_01.MP4
if ./gopro-rename -vf $TESTDIR; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR

echo "===> optional prefix"
init $TESTDIR
./gopro-rename -vp AAA $TESTDIR
if [ "$(ls $TESTDIR)" = "$OUTFILES_WITH_PREFIX" ]; then
    echo OK
else
    echo "Failed"
    exit 1
fi
cleanup $TESTDIR