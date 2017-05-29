import sys
import random

N = 100001
print 0, 0
sys.stdout.flush()
d = int(raw_input())
s = set()
for r in xrange(N):
    c = d - r
    if c < 0:
        continue
    s.add((r, c))

while len(s) > 1:
    r, c = random.sample(s, 1)[0]
    print r, c
    sys.stdout.flush()
    d = int(raw_input())
    new_s = set()
    for dr in xrange(-d, d+1):
        nr = r + dr
        nc = c + d - abs(dr)
        if nr >= 0 and nr < N and nc >= 0 and nc < N:
            new_s.add((nr, nc))
        nc = c - d + abs(dr)
        if nr >= 0 and nr < N and nc >= 0 and nc < N:
            new_s.add((nr, nc))
    s &= new_s

r, c = s.pop()
print r, c

