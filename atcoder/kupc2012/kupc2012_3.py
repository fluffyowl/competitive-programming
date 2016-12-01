N, K = map(int, raw_input().split())
kirai = [[] for i in xrange(N+1)]
for i in xrange(K):
    m = map(int, raw_input().split())[1:]
    for x in m:
        kirai[x] = m
ans = [False for i in xrange(N+1)]
for i in xrange(int(raw_input())):
    a, b = map(int, raw_input().split())
    if b in kirai[a]:
        ans[a] = True
        ans[b] = True
print sum(ans)
