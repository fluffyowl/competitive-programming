f = 1
for i in xrange(1, min(input()+1, 100)):
    f = f * i

if f < 10**12:
    print f % (10**12)
else:
    print "%012d" % (f % (10**12))

