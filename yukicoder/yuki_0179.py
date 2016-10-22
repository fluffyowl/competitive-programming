H, W = map(int, raw_input().split())
s = [raw_input() for i in xrange(H)]
dxdy = [(i, j) for i in xrange(H) for j in xrange(-W+1, W)]
xy = [(i, j) for i in xrange(H) for j in xrange(W)]

for dx, dy in dxdy:
    if dy <= 0 and dx == 0:
        continue
    taiou = set()
    for x, y in xy:
        if s[x][y] == '.':
            continue
        nx, ny = x+dx, y+dy
        if (x, y) in taiou:
            continue
        if nx >= H or ny >= W or s[nx][ny] == '.':
            break
        taiou.add((nx, ny))
    else:
        if len(taiou) > 0:
            print 'YES'
            break
else:
    print 'NO'

