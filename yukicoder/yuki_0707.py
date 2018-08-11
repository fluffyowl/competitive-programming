import math

H, W = map(int, raw_input().split())
A = [raw_input() for _ in xrange(H)]
B = []
for i in xrange(H):
    for j in xrange(W):
        if A[i][j] == '1':
            B.append((i+1, j+1))

ans = float('inf')
for i in xrange(H+2):
    cols = range(1, W+1) if i == 0 or i == H+1 else [0, W+1]
    for j in cols:
        tmp = 0
        for x, y in B:
            tmp += math.sqrt((i-x)**2 + (j-y)**2)
        ans = min(ans, tmp)

print "%.9f" % ans

