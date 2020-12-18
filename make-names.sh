#! /bin/bash

function ymdname() {
    # 010619p.mp3
    # mmddyy 
    echo "$*" | sed 's/^\([0-9][0-9]\)\([0-9][0-9]\)\([0-9][0-9]\)/20\3\/20\3-\1-\2-/; s/[:;]/-/g'
}

function makenamedfile() {
    while read SOURCE; do
        case "$SOURCE" in
            *.mp3) 
                YMD=`ymdname "${SOURCE}"`
                TARGET="names/${YMD/.mp3} $NAME.mp3"
                if [ -f "$SOURCE" ] ; then
                    [ -f "$TARGET" ] || ln "$SOURCE" "$TARGET" 
                else
                    echo 1>&2 "# Missing $SOURCE : $NAME" 
                fi
            ;;
        esac
        NAME="$SOURCE"
    done
}

mkdir -p names/20{01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19}
grep \"prch-title\\\|mp3 page5.html | sed 's:<a href="[^"]*/::;s/"><.*//; s:<[^>]*>::g' | tr -d '\r' | tr ':?' '--' | makenamedfile

