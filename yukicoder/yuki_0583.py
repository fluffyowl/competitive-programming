class UnionFind(object):
    def __init__(self, n):
        self.table = [-1 for _ in xrange(n)]

    def unite(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.table[x] >= self.table[y]:
            self.table[y] += self.table[x]
            self.table[x] = y
        else:
            self.table[x] += self.table[y]
            self.table[y] = x

    def find(self, x):
        if self.table[x] < 0:
            return x
        self.table[x] = self.find(self.table[x])
        return self.table[x]


N, M = map(int, raw_input().split())
D = [0 for _ in xrange(N)]
U = UnionFind(N)
for _ in xrange(M):
    a, b = map(int, raw_input().split())
    D[a] += 1
    D[b] += 1
    U.unite(a, b)
union = all(U.find(a) == U.find(b) for a in xrange(N) for b in xrange(N) if D[a] > 0 and D[b] > 0)
odd = sum(d % 2 for d in D)
print "YES" if (odd == 0 or odd == 2) and union else "NO"

