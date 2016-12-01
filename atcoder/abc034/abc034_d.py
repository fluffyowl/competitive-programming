N, K = map(int, raw_input().split())
wp = [map(int, raw_input().split()) for _ in xrange(N)]
upper = 100.0
lower = 0.0
EPS = 10**(-11)
while upper - lower > EPS:
    middle = (upper+lower) / 2
    swp = sorted(wp, key=lambda x:x[0]*(middle-x[1]))
    W, S = 0, 0
    for i in xrange(K):
        w, p = swp[i]
        W += w
        S += w * p / 100.0
    if S / W * 100 - middle > EPS:
        lower = middle
    else:
        upper = middle

print '%.10f'%upper
