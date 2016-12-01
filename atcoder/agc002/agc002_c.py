N, L = map(int, raw_input().split())
a = map(int, raw_input().split())
b = [a[i]+a[i+1] for i in xrange(N-1)]
maxb = max(b)
maxbi = b.index(maxb)
if maxb < L:
    print 'Impossible'
    exit()
print 'Possible'
for i in xrange(maxbi):
    print i+1
for i in xrange(N-2, maxbi, -1):
    print i+1
print maxbi+1
