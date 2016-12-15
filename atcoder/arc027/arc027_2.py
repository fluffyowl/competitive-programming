class UnionFind(object):
    def __init__(self, n):
        self.table = [-1 for _ in xrange(n)]
        self.confirmed = [False for _ in xrange(n)]

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.confirmed[x] or self.confirmed[y]:
            self.confirmed[x] = True
            self.confirmed[y] = True
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

uf = UnionFind(26)
N = input()
s1 = raw_input()
s2 = raw_input()
for c1, c2 in zip(s1, s2):
    if c1.isalpha() and c2.isalpha():
        uf.union(ord(c1)-ord('A'), ord(c2)-ord('A'))
    elif c1.isalpha():
        uf.confirmed[uf.find(ord(c1)-ord('A'))] = True
    elif c2.isalpha():
        uf.confirmed[uf.find(ord(c2)-ord('A'))] = True        

ans = 1
for i, c in enumerate(s1):
    if c.isalpha() and not uf.confirmed[uf.find(ord(c)-ord('A'))]:
        ans *= 9 if i == 0 else 10
        uf.confirmed[uf.find(ord(c)-ord('A'))] = True

print ans
