H, W = map(int, raw_input().split())
B = [raw_input() for _ in xrange(H)]
r, c = 0, 0
s = set()

while r != H-1 or c != W-1:
    s.add((r, c))
    if r < H-1 and c < W-1:
        if B[r+1][c] == '#' and B[r][c+1] == '#':
            print 'Impossible'
            exit()
        elif B[r+1][c] == '.' and B[r][c+1] == '.':
            print 'Impossible'
            exit()
        elif B[r+1][c] == '#' and B[r][c+1] == '.':
            r += 1
            continue
        else:
            c += 1
            continue
    elif r == H-1:
        if B[r][c+1] == '.':
            print 'Impossible'
            exit()
        else:
            c += 1
            continue
    else:
        if B[r+1][c] == '.':
            print 'Impossible'
            exit()
        else:
            r += 1
            continue

s.add((H-1, W-1))

t = set()
for i in xrange(H):
    for j in xrange(W):
        if B[i][j] == '#':
            t.add((i, j))

if s == t:
    print 'Possible'
else:
    print 'Impossible'
