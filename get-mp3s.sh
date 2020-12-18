#! /bin/bash

# RATE_LIMIT="--rate-limit=130K"
find -name page5.html -ctime -5 | grep -q . || wget -O page5.html  http://faithfulwordbaptist.org/page5.html
cat page5.html |
    grep -Po 'http://\S*mp3' |
    while read URL; do
        F="${URL/*\/}"
        [ -s "$F" ] || wget $RATE_LIMIT --continue "$URL";
    done
