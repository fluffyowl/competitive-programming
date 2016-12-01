N, M, Q = map(int, raw_input().split())
d = {}
for i in xrange(N):
    s = raw_input()
    for j in xrange(M):
        if s[j] != '*':
            d[s[j]] = (i, j)
for i in xrange(Q):
    q = raw_input()
    if q in d:
        print d[q][0]+1, d[q][1]+1
    else:
        print 'NA'
