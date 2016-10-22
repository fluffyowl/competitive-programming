N = input()
S = [int(raw_input()) for _ in xrange(N)]
M = input()
dist = [[float('inf') for i in xrange(N)] for j in xrange(N)]
for _ in xrange(M):
    a, b, c = map(int, raw_input().split())
    dist[a][b] = c
    dist[b][a] = c

for k in xrange(N):
    for i in xrange(N):
        for j in xrange(N):
            if dist[i][j] > dist[i][k] + dist[k][j]:
                dist[i][j] = dist[i][k] + dist[k][j]

m = float('inf')
d = lambda x, y:dist[0][x]+dist[x][y]+dist[y][N-1]+S[i]+S[j]
for i in xrange(1, N-1):
    for j in xrange(i+1, N-1):
        m = min(m, d(i, j), d(j, i))
print m
