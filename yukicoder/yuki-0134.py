sakaya = map(int, raw_input().split())
N = input()
points = [map(float, raw_input().split()) for _ in xrange(N)]
W = sum(p[2] for p in points)

def cost(p1, p2, weight):
    T = (weight+100.0)/120
    return abs(p1[0]-p2[0])*T + abs(p1[1]-p2[1])*T

mem = {}
def rec(p, b, w):
    if (p, b) in mem:
        return mem[(p, b)]
    w -= points[p][2]
    if b == ((1 << N) - 1):
        return cost(sakaya, points[p], w)+points[p][2]

    m = float('inf')
    for i in xrange(N):
        if (1 << i) & b:
            continue
        m = min(m, rec(i, (1<<i)+b, w)+cost(points[p], points[i], w)+points[p][2])
    mem[(p, b)] = m
    return m

print min(rec(x, 1<<x, W)+cost(sakaya, points[x], W) for x in xrange(N))
