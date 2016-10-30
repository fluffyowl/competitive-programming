# -*- coding: utf-8 -*-
import sys, codecs
sys.stdin  = codecs.getreader('utf-8')(sys.stdin)
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
import re
S = raw_input()
sp1 = filter(None, re.split(u'ｗ+', S))
sp2 = map(len, filter(None, re.split(u'[^ｗ]+', S)))
if len(sp1) == 0 or len(sp2) == 0:
    print ''
    exit()
if S.startswith(u'ｗ'):
    sp2.pop(0)
if not S.endswith(u'ｗ'):
    sp2.append(0)
m = max(sp2)
if m == 0:
    print ''
    exit()
for i in xrange(len(sp1)):
    if sp2[i] == m:
        print sp1[i]
 

