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
[ "$(ls $TESTDIR)" = "$OUTFILES" ] && echo OK || { echo "Failed"; exit 1; }
cleanup $TESTDIR

echo "===> work on dirs"
init $TESTDIR
./gopro-rename -v $TESTDIR
[ "$(ls $TESTDIR)" = "$OUTFILES" ] && echo OK || { echo "Failed"; exit 1; }
cleanup $TESTDIR

echo "===> dry-run mode"
init $TESTDIR
./gopro-rename -n $TESTDIR
[ "$(ls $TESTDIR)" = "$INFILES" ] && echo OK || { echo "Failed"; exit 1; }
cleanup $TESTDIR

echo "===> non-recursive"
init $TESTDIR/subdir
./gopro-rename -v $TESTDIR
[ "$(ls $TESTDIR/subdir)" = "$INFILES" ] && echo OK || { echo "Failed"; exit 1; }
cleanup $TESTDIR

echo "===> recursive"
init $TESTDIR/subdir
./gopro-rename -vr $TESTDIR
[ "$(ls $TESTDIR/subdir)" = "$OUTFILES" ] && echo OK || { echo "Failed"; exit 1; }
cleanup $TESTDIR
