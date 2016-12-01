C = int(raw_input())
L = [map(int, raw_input().split()) for i in xrange(C)]
a, b, c = [],[],[]
for i in xrange(C):
    x, y, z = sorted(L[i])
    a.append(z)
    b.append(y)
    c.append(x)
print max(a)*max(b)*max(c)
