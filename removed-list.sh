#! /bin/bash

for a in *.mp3; do grep $a page5.html -q || echo $a; done
