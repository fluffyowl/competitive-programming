import math

N, K = map(int, raw_input().split())
table = [0 for i in xrange(N+1)]

for i in xrange(2, N+1):
    if table[i] > 0:
        continue
    for j in xrange(i, N+1, i):
        table[j] += 1

print len([t for t in table if t >= K])

