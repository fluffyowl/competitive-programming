from itertools import permutations
P = [map(int, raw_input().split()) for _ in xrange(5)]
crs = lambda p1, p2: p1[0]*p2[1]-p1[1]*p2[0]
v = lambda p1, p2: [p2[0]-p1[0], p2[1]-p1[1]]
def inside(a, b, c, d):
    g1 = crs(v(c, a), v(a, d))
    g2 = crs(v(a, b), v(b, d))
    g3 = crs(v(b, c), v(c, d))
    return (g1 >= 0 and g2 >= 0 and g3 >= 0) or (g1 <= 0 and g2 <= 0 and g3 <= 0)
for a, b, c, d, e in permutations(range(5)):
    if inside(P[a], P[b], P[c], P[d]) or inside(P[a], P[b], P[c], P[e]):
        print 'NO'
        exit()
print 'YES'

