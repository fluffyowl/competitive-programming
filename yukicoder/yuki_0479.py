n, m = map(int, raw_input().split())
ans = [False for i in xrange(n)]
query = sorted([map(int, raw_input().split()) for _ in xrange(m)])
used = [False for _ in xrange(n)]
for i in xrange(m-1, -1, -1):
    a, b = query[i]
    if not used[b]:
        ans[a] = True
        used[a] = True
#print ans
print int(''.join(map(lambda x: '01'[x], reversed(ans))))

