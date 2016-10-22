N, M = map(int, raw_input().split())
s1, s2 = raw_input(), raw_input()

dist = [[0 for i in xrange(M+1)] for j in xrange(N+1)]

for i in xrange(N+1):
    dist[i][0] = i
for j in xrange(M+1):
    dist[0][j] = j
for i in xrange(1, N+1):
    for j in xrange(1, M+1):
        dist[i][j] = min(dist[i-1][j]+1, dist[i][j-1]+1, dist[i-1][j-1]+(s1[i-1]!=s2[j-1]))
print dist[N][M]

