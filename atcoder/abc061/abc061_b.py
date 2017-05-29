n, m = map(int, raw_input().split())
ans = [0 for _ in xrange(n)]
for i in xrange(m):
    a, b = map(int, raw_input().split())
    ans[a-1] += 1
    ans[b-1] += 1
for i in xrange(n):
    print ans[i]
