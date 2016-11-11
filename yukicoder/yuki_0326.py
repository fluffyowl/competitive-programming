N = input()
K = input()
amida = range(1, N+1)
for i in xrange(K):
    x, y = map(int, raw_input().split())
    amida[x-1], amida[y-1] = amida[y-1], amida[x-1]
seikai = sorted((a, i+1) for i, a in enumerate(map(int, raw_input().split())))

ans = []
for pos, i in seikai:
    cur = amida.index(i)
    while cur+1 > pos:
        ans.append((cur, cur+1))
        amida[cur], amida[cur-1] = amida[cur-1], amida[cur]
        cur -= 1
print len(ans)
for a in ans:
    print a[0], a[1]

