#! /bin/bash

echo= 
# echo=echo

[ x"$1" = x"recode" ] && {
    shift
    SRC="$1"

    PREACHER="Faithful Word Baptist Church"
    DST="${SRC/names/opus}"
    DST="${DST/.mp3/.opus}"
    DIR=$( dirname "$DST" )
    [ -d $DIR ] || mkdir -p $DIR
    TITLE="${SRC/*\/}"
    TITLE="${TITLE/.mp3}"
    [ -s "$DST" ] && exit
    $echo ffmpeg -nostdin -i "$SRC" -metadata genre='Preaching'  -metadata title="$TITLE" -metadata artist="$PREACHER" -ar 16000 -ac 1 -b:a 12k "$DST"
    $echo touch --reference="$SRC" "$DST"
    exit
}

# SRC=names/b/c/xx.mp3
# DST=opus/b/c/xx.opus
#
find names -type f -name \*.mp3 | sort | parallel -j $(( $( grep -c processor /proc/cpuinfo ) - 1 ))  $0 recode {}

