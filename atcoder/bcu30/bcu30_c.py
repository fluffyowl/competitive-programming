import itertools

N, M = map(int, raw_input().split())
d1 = {k:set() for k in xrange(N)}
d2 = {k:set() for k in xrange(N)}
for _ in xrange(M):
    a, b = map(int, raw_input().split())
    d1[a-1].add(b-1)
    d2[b-1].add(a-1)


ans = 0
for i in xrange(N):
    for j in xrange(N):
        ans += len(d1[i] & d2[j])**2

print ans
