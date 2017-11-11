H, W = map(int, raw_input().split())
A = [raw_input() for _ in xrange(H)]
B = [[0 for j in xrange(W)] for i in xrange(H)]

dr = [-1, 0, 1, -1, 1, -1, 0, 1]
dc = [-1, -1, -1, 0, 0, 1, 1, 1]


for i in xrange(H):
    for j in xrange(W):
        if A[i][j] == '#':
            B[i][j] = '#'
            continue
        for k in xrange(8):
            ni = i + dr[k]
            nj = j + dc[k]
            if ni < 0 or ni >= H or nj < 0 or nj >= W:
                continue
            if A[ni][nj] == '#':
                B[i][j] += 1

for i in xrange(H):
    print ''.join(map(str, B[i]))
