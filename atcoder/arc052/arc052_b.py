import math
N, Q = map(int, raw_input().split())
ruiseki = [0 for i in xrange(10**4*2+1)]
for i in xrange(N):
    x, r, h = map(int, raw_input().split())
    taiseki = math.pi * (float(r)/h)**2 / 3
    for i in xrange(h):
        ruiseki[x+h-i] += taiseki*((i+1)**3-i**3)
for i in xrange(len(ruiseki)-1):
    ruiseki[i+1] += ruiseki[i]

for q in xrange(Q):
    a, b = map(int, raw_input().split())
    print ruiseki[b] - ruiseki[a]
