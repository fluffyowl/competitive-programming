from math import log10, ceil

N, M = map(int, raw_input().split())
R = map(int, raw_input().split())

cnt = [0 for _ in xrange(N+1)]
for r in R:
    cnt[r] += 1;

X = N * log10(M)
C = M

for i in xrange(N+1):
    if i > 0:
        X += C * log10(i)
    C -= cnt[i]

for i in xrange(1, N+1):
    X -= log10(i)

print int(ceil(X))
