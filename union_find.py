class UnionFind(object):
    def __init__(self, n):
        self.table = [-1 for _ in xrange(n)]

    def union(self, x, y):
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
