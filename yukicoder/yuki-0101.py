from fractions import gcd

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
        if self.uf[x] < 0:
            return x
        else:
            self.uf[x] = self.find(self.uf[x])
            return self.uf[x]

N = input()
K = input()
xy = [map(int, raw_input().split()) for _ in xrange(K)]
A = range(N)

for x, y in xy:
    A[x-1], A[y-1] = A[y-1], A[x-1]

uf = UnionFind(N)
for i in xrange(N):
    uf.union(i, A[i])

uf = [abs(u) for u in uf.uf if u<0]
lcm = uf[0]
for i in xrange(1, len(uf)):
    lcm = lcm*uf[i]/gcd(lcm, uf[i])
print lcm

