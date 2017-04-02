N, M = map(int, raw_input().split())
ab = [map(int, raw_input().split()) for _ in xrange(N)]
cd = [map(int, raw_input().split()) for _ in xrange(M)]

for i in xrange(N):
    mi = -1
    mv = float('inf')
    for j in xrange(M):
        dist = abs(ab[i][0]-cd[j][0]) + abs(ab[i][1]-cd[j][1])
        if dist < mv:
            mv = dist
            mi = j
    print mi+1
