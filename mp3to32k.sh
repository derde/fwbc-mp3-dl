#! /bin/bash

# Maje 32kbps audio

echo= 

[ x"$1" = x"recode" ] && {
    shift
    SRC="$1"
    DST="${SRC/\/names\/}"
    DST="32/$DST"
    mkdir -p "$(dirname "$DST")"
    [ -s "$DST" ] && exit
    lame "$SRC" -m s -a -b 32 "$DST" &&
    touch --reference="$SRC" "$DST"
    exit
}

find names -type f -name \*.mp3 | sort | parallel -j $(( $( grep -c processor /proc/cpuinfo ) - 1 ))  $0 recode {}
