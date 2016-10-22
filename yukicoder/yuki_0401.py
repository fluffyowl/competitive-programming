N = input()
dxdy = [(0, 1), (1, 0), (0, -1), (-1, 0)]
x, y = 0, 0
d = 0
ans = [[0 for i in xrange(N)] for j in xrange(N)]

for i in xrange(1, N*N+1):
    ans[x][y] = i
    nx, ny = x + dxdy[d][0], y + dxdy[d][1]
    if nx >= N or ny >= N or ans[nx][ny] != 0:
        d = (d+1)%4
        x, y = x + dxdy[d][0], y + dxdy[d][1]
    else:
        x, y = nx, ny

for a in ans:
    print ' '.join(map(lambda x:'%03d'%x, a))

