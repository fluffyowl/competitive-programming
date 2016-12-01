N, M = map(int, raw_input().split())
a = range(N+1)
kiiteru = 0
for i in xrange(M):
    kiku = int(raw_input())
    a[kiiteru], a[kiku] = a[kiku], a[kiiteru]
    kiiteru = kiku

ans = [0 for i in xrange(N+1)]
for i, e in enumerate(a):
    ans[e] = i

for i in xrange(1, N+1):
    print ans[i]
