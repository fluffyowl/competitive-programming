N, K = map(int, raw_input().split())
spuri = [map(int, raw_input().split()) + [0, i] for i in xrange(N)]
u_rank = [0 for _ in xrange(10**5+1)]

spuri.sort(key=lambda x:(-x[0], x[1]))
for i in xrange(N):
    spuri[i][3] = u_rank[spuri[i][2]]
    u_rank[spuri[i][2]] += 1
spuri.sort(key=lambda x:(-x[0], x[3], x[1]))
for i in xrange(K):
    print spuri[i][4]
