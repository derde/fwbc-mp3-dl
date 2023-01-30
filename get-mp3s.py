#! /usr/bin/python3

import os
import re

badurls=list(map(str.strip,open('BADURLS','r').readlines()))

# RATE_LIMIT="--rate-limit=130K"
os.system('''
find -name page5.html -ctime -5 | grep -q . || wget -O page5.html  http://faithfulwordbaptist.org/page5.html
''')
fd=open('page5.html','r')
for line in fd:
    m=re.search(r'(https?://\S*mp3)',line)
    if m:
        url=m.group(1)
        file=url.split('/')[-1]
        if url in badurls:
            continue
        if os.path.exists(file) and os.stat(file).st_size>10240:
            continue
        os.system(''' wget --continue %s ''' % ( url ) )
