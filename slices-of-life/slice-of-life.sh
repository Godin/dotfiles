#!/bin/sh

DIST_OS=`uname -s | tr [:upper:] [:lower:] | tr -d [:blank:]`

# Check if user has been idle too long
if [ "$DIST_OS" = "darwin" ]
then
    MAX_IDLE_SECONDS="600.0" # seconds
    IDLE_SECONDS=`ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF/1000000000; exit}'`
    COMPARE=$(echo "r=0;if($IDLE_SECONDS > $MAX_IDLE_SECONDS)r=1;r" | bc)
    if [ $COMPARE = '1' ]
    then
        exit
    fi
else
    MAX_IDLE=600 # seconds
    IDLE=$(DISPLAY=:0 idletime)
    if [ $IDLE -gt $MAX_IDLE ]; then
        exit
    fi
fi

DIR=~/slices-of-life
mkdir -p $DIR

NOW=$(date "+%Y-%m-%dT%H-%M-%SZ%z")

if [ "$DIST_OS" = "darwin" ]
then
    SCREEN=$DIR"/"$NOW"-screenshot.jpeg"
    CAMERA=$DIR"/"$NOW"-camera.jpeg"

    /usr/sbin/screencapture -t jpeg -m -x $SCREEN
    /usr/local/bin/imagesnap $CAMERA
else
    SCREEN=$DIR"/"$NOW"-screenshot.jpeg"
    CAMERA=$DIR"/"$NOW"-camera.jpeg"

    # Take screenshot
    ffmpeg -loglevel quiet -f x11grab -s 1366x768 -i :0.0 -vframes 1 $SCREEN
    # Take a photo
    ffmpeg -loglevel quiet -f video4linux2 -s 320x240 -i /dev/video0 -r 1 -ss 3 -s 640x480 -vframes 1 $CAMERA
fi
