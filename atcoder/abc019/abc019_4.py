import sys
N = int(raw_input())
farest_dist = -1
farest_node = None
for i in xrange(2, N+1):
    print "? {0} {1}".format(1, i)
    sys.stdout.flush()
    dist = int(raw_input())
    if dist > farest_dist:
        farest_dist = dist
        farest_node = i
        
farest_dist = -1
for i in xrange(1, N+1):
    if i == farest_node:
        continue
    print "? {0} {1}".format(farest_node, i)
    sys.stdout.flush()
    dist = int(raw_input())
    if dist > farest_dist:
        farest_dist = dist

print "! {0}".format(farest_dist)
