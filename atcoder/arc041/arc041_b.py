H, W = map(int, raw_input().split())
b1 = [map(int, raw_input()) for i in xrange(H)]
b2 = [[0 for j in xrange(W)] for i in xrange(H)]

d = [(-1, 0), (1, 0), (0, -1), (0, 1)]
for x in xrange((H-2)/2):
    for c in xrange(1, W-1):
        b2[x+1][c] = b1[x][c]
        for nr, nc in d:
            b1[x+1+nr][c+nc] -= b2[x+1][c]
        b2[H-x-2][c] = b1[H-x-1][c]
        for nr, nc in d:
            b1[H-x-2+nr][c+nc] -= b2[H-x-2][c]
if H%2:
    for c in xrange(1, W-1):
        b2[H/2][c] = b1[H/2-1][c]

for L in b2:
    print ''.join(map(str, L))
