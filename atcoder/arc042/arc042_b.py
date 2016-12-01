from math import sqrt, sin
dist = lambda x,y : sqrt(x*x + y*y)
p = map(int, raw_input().split())
vs = [tuple(map(int, raw_input().split())) for i in xrange(int(raw_input()))]
d = float('inf')

for i in range(len(vs)):
    a, b = (vs[i], vs[i+1]) if i < len(vs)-1 else (vs[i], vs[0])
    vx = (b[0] - a[0], b[1] - a[1])
    vy = (p[0] - a[0], p[1] - a[1])
    d = min(d, (vx[0]*vy[1]-vx[1]*vy[0])/dist(*vx))
print d
