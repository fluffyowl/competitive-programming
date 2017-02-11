a = map(int, raw_input().split())
for i in xrange(1, 10):
    if a[i-1] != i:
        print i
        exit()
print 10

