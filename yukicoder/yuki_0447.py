from fractions import Fraction as F
score = lambda A, B: 50*A+int(F(50*A, F(4,5)+F(1,5)*B))

N = input()
L = map(int, raw_input().split())
ACed = [0 for _ in xrange(N)]
T = input()
d = {}

for i in xrange(T):
    n, p = raw_input().split()
    p = ord(p) - ord('A')
    if n not in d:
        d[n] = [0 for _ in xrange(N+1)]
    ACed[p] += 1
    d[n][p] = score(L[p], ACed[p])
    d[n][N] = i

ans = sorted(d.keys(), key=lambda x:(-sum(d[x][:-1]), d[x][-1]))
for i, k in enumerate(ans):
    print i+1, k, ' '.join(map(str, d[k][:-1])), sum(d[k][:-1])

