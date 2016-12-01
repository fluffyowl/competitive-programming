import re
p = r'tokyo|kyoto'

for i in xrange(input()):
    print len(re.findall(p, raw_input()))
