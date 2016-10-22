import math

class UnionFind(object):
    def __init__(self, n):
        self.uf = [-1 for _ in xrange(n)]

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.uf[x] >= self.uf[y]:
            self.uf[y] += self.uf[x]
            self.uf[x] = y
        else:
            self.uf[x] += self.uf[y]
            self.uf[y] = x

    def find(self, x):
        leaves = []
        while self.uf[x] >= 0:
            leaves.append(x)
            x = self.uf[x]
        for lf in leaves:
            self.uf[lf] = x
        return x

    def get_unions(self):
        unions = {}
        for i in xrange(N):
            root = self.find(i)
            if root in unions:
                unions[root].append(i)
            else:
                unions[root] = [i]
        return unions
    
N = input()
p = [map(int, raw_input().split()) for _ in xrange(N)]

if N == 0:
    print 1
    exit()

uf = UnionFind(N)
dist = [[0 for j in xrange(N)] for i in xrange(N)]
for i in xrange(N):
    for j in xrange(i+1, N):
        d = (p[i][0]-p[j][0])**2+(p[i][1]-p[j][1])**2 
        if d <= 100:
            uf.union(i, j)
        dist[i][j] = d
        dist[j][i] = d

m = 0
for union in uf.get_unions().values():
    for i in xrange(len(union)):
        for j in xrange(i+1, len(union)):
            m = max(m, dist[union[i]][union[j]])
print math.sqrt(m)+2

